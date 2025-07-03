import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/presentation/pages/weatherScreen/weather_screen.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final int temp;
  final String condition;
  final int high;
  final int low;
  final bool isDark;

  const WeatherCard({
    super.key,
    required this.city,
    required this.temp,
    required this.condition,
    required this.high,
    required this.low,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(const WeatherScreen()),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.blue[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // City & temp
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(city,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black)),
                    Text("Current Weather",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Colors.white : Colors.black)),
                  ],
                ),
                Text(
                  "$temp°",
                  style: TextStyle(
                    fontSize: 40,
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Weather description and range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  condition,
                  style: TextStyle(
                    fontSize: 18,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "$high",
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "$low",
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
