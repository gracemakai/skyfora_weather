import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skyfora_weather/cubit/weather_state.dart';
import 'package:skyfora_weather/service/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;

  WeatherCubit(this.weatherService) : super(WeatherInitial());

  Future<void> fetchWeather(double lat, double lon) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherService.fetchWeather(lat, lon);

      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
