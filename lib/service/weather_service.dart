import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:skyfora_weather/models/weather_model.dart';

class WeatherService {
  final String apiKey = dotenv.get('APIKEY');
  final String baseUrl = '${dotenv.get('BASEURL')}/forecast';

  Future<WeatherResponse> fetchWeather(double lat, double lon) async {
    final url = Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherResponse.fromJson(data);
      } else {
        throw Exception('Failed to fetch weather data: ${response.reasonPhrase}');
      }
    } catch (e, s) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}