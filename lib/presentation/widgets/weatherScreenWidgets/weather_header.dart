import 'package:flutter/material.dart';

class WeatherHeader extends StatelessWidget {
  final bool isDark;
  final String city;
  final int temp;
  final String condition;
  final int high;
  final int low;

  const WeatherHeader({
    super.key,
    required this.isDark,
    required this.city,
    required this.temp,
    required this.condition,
    required this.high,
    required this.low,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey[300] : Colors.grey[700];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        Text(
          city,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: textColor,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 8),

        
        Text(
          "$temp°C",
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),


        Text(
          condition,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: subTextColor,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),

        // High / Low
        Text(
          "H: $high°C  •  L: $low°C",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: subTextColor,
          ),
        ),
      ],
    );
  }
}
