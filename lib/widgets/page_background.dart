import 'package:flutter/material.dart';

Widget getBackgroundByWeather(String condition) {
  switch (condition.toLowerCase()) {
    case 'clear':
      return _buildBackground(Colors.blue, "assets/images/clear.jpg");
    case 'clouds':
      return _buildBackground(Colors.grey, "assets/images/cloudy.jpg");
    case 'rain':
      return _buildBackground(Colors.blueGrey, "assets/images/rainy.jpg");
    case 'storm':
      return _buildBackground(Colors.black, "assets/images/rainy.jpg");
    case 'snow':
      return _buildBackground(Colors.white, "assets/images/snow.jpg");
    default:
      return _buildBackground(
          Colors.lightBlue, "assets/images/default_weather.jpg");
  }
}

Widget _buildBackground(Color color, String image) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      image: DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.cover,
      ),
    ),
  );
}