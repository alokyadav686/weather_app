import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/presentation/controllers/weather_controller.dart';
import 'package:weather_app/presentation/pages/weatherScreen/weather_screen.dart';
import 'package:lottie/lottie.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final bool isDark;

  WeatherCard({super.key, required this.weather, required this.isDark});
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => Get.to(
            () => WeatherScreen(weather: weather),
            // transition: Transition.zoom,
            duration: Duration(milliseconds: 500),
          ),

      child: Hero(
        tag: weather.name,
        transitionOnUserGestures: true,
        flightShuttleBuilder: (
          flightContext,
          animation,
          direction,
          fromContext,
          toContext,
        ) {
          return ScaleTransition(
            scale: animation.drive(
              Tween(
                begin: 1.0,
                end: 1.05,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: toContext.widget,
          );
        },
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                child: Opacity(
                  opacity: isDark ? 0.5 : 1,
                  child: Lottie.asset(
                    weatherController.getWeatherAnimation(
                      weather.weather.first.description,
                    ),

                    fit: BoxFit.contain,
                    repeat: true,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? Colors.grey[800]?.withOpacity(0.4)
                          : Colors.blue[100]?.withOpacity(0.4),
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
                            Text(
                              weather.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              "Current Weather",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${weather.main.temp.round()}°",
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
                          weather.weather.first.description,
                          style: TextStyle(
                            fontSize: 18,
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'H:${weather.main.tempMax.round()}°',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'L:${weather.main.tempMin.round()}°',
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
            ],
          ),
        ),
      ),
    );
  }
}
