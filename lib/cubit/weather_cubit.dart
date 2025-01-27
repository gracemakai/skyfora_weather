import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skyfora_weather/cubit/weather_state.dart';
import 'package:skyfora_weather/service/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;

  WeatherCubit(this.weatherService) : super(WeatherInitial()){
    fetchWeatherForCurrentLocation();
  }

  Future<void> fetchWeather(double lat, double lon) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherService.fetchWeather(lat, lon);

      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
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
}
