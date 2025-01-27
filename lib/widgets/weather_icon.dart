import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    super.key,
    required this.icon,
  });

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://openweathermap.org/img/wn/$icon@2x.png',
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          height: 0.03.sh,
          width: 0.sw,
        );
      },
    );
  }
}
