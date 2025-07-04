import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/common/utils/contants/text_constants.dart';

class FeelsHumd extends StatelessWidget {
  final int feelsLike;
  final int humidity;

  final bool isDark;
  final int temp;

  const FeelsHumd({
    super.key,
    required this.feelsLike,
    required this.isDark,
    required this.humidity,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    Color getTextColor() => isDark ? Colors.white : Colors.black;

    return Row(
      children: [
        // Feels Like Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            height: 230,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.thermostat, color: getTextColor()),
                const SizedBox(height: 8),
                Text(
                  "Feels Like",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: getTextColor(),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "$feelsLike°",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: getTextColor(),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  feelsLike > temp
                      ? AppTextConstants.hotter
                      : AppTextConstants.colder,
                  style: TextStyle(
                    fontSize: 14,
                    color: getTextColor().withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Humidity Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 230,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.water_drop, color: getTextColor()),
                const SizedBox(height: 8),
                Text(
                  "Humidity",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: getTextColor(),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "$humidity%",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: getTextColor(),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Humidity refers to the amount of moisture in the air.",
                  style: TextStyle(
                    fontSize: 14,
                    color: getTextColor().withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
