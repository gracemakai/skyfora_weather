import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyfora_weather/cubit/weather_state.dart';
import 'package:skyfora_weather/models/weather_model.dart';
import 'package:skyfora_weather/service/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;

  WeatherCubit(this.weatherService) : super(WeatherInitial()){
    isOnline();
    fetchWeatherForCurrentLocation();
  }

  Future<void> fetchWeather(double lat, double lon) async {
    final isConnected = await isOnline();

    if(isConnected) {
      emit(WeatherLoading());
      try {
        final weather = await weatherService.fetchWeather(lat, lon);

        emit(WeatherLoaded(weather));
        saveWeatherData(weather);
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    }else{
      final cachedWeather = await getCachedWeatherData();
      if (cachedWeather != null) {
        emit(WeatherLoaded(cachedWeather));
      } else {
        emit(WeatherError('No internet and no cached data available'));
      }
    }
  }

  void fetchWeatherForCurrentLocation() async {
    final position = await getCurrentLocation();
    if (position != null) {
      fetchWeather(
        position.latitude,
        position.longitude,
      );
    } else {
      debugPrint("Could not get location");
    }
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> saveWeatherData(WeatherResponse weatherResponse) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('weather', jsonEncode(weatherResponse.toJson())); // Save weather as JSON string
    prefs.setString('lastUpdated', DateTime.now().toIso8601String()); // Save last updated time
  }

  Future<WeatherResponse?> getCachedWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final weatherJson = prefs.getString('weather');
    if (weatherJson != null) {
      return WeatherResponse.fromJson(jsonDecode(weatherJson)); // Convert JSON to WeatherResponse
    }
    return null;
  }

  Future<DateTime?> getLastUpdated() async {
    final prefs = await SharedPreferences.getInstance();
    final isConnected = await isOnline();
    final lastUpdatedString = prefs.getString('lastUpdated');
    if (lastUpdatedString != null && !isConnected) {
      return DateTime.parse(lastUpdatedString);
    }
    return null;
  }


  Future<bool> isOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
