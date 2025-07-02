import 'package:flutter/material.dart';
import 'package:weather_app/common/styles/spacing_styles.dart';
import 'package:weather_app/common/utils/helpers/helper.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Padding(
        padding: AppSpacingStyles.paddingWithAppBarHeight,
        child: Column(
          children: [
            Text(
              "Ghaziabad",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "25°C",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Text(
              "Sunny",
              style: TextStyle(
                fontSize: 20,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            Text(
              "H: 30°C, L: 20°C",
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white70 : Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Hourly forecast",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: isDark ? Colors.white70 : Colors.black,
                          ),
                        ),
                        Text(
                          "Weekly forecast",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: isDark ? Colors.white70 : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: isDark ? Colors.white30 : Colors.black26,
                      thickness: 1,
                    ),

                    SizedBox(height: 20),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.white,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "12 AM",
                              style: TextStyle(
                                fontSize: 16,
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.cloud,
                              size: 40,
                              color: isDark ? Colors.white : Colors.black,
                            ),

                            Text(
                              "19°",
                              style: TextStyle(
                                fontSize: 26,
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
