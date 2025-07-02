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
        child: SingleChildScrollView(
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
                  color: isDark ? Colors.grey[850] : Colors.blue[50],
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

              const SizedBox(height: 20),

              // aqi
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[850] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.air,
                          size: 30,
                          color: isDark ? Colors.white : Colors.blue,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Air Quality Index (AQI)",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // AQI value and category
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "AQI: 42",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Good",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Health message
                    Text(
                      "Air quality is considered satisfactory, and air pollution poses little or no risk.",
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // AQI level bar
                    Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(height: 8, color: Colors.yellow),
                            ),
                            Expanded(
                              child: Container(height: 8, color: Colors.orange),
                            ),
                            Expanded(
                              child: Container(height: 8, color: Colors.red),
                            ),
                            Expanded(
                              child: Container(height: 8, color: Colors.purple),
                            ),
                            Expanded(
                              child: Container(height: 8, color: Colors.brown),
                            ),
                            Expanded(
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Positioned(
                          left: 30,
                          top: -3,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.4),
                                width: 1.5,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
