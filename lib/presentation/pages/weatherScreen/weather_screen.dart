import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/common/styles/spacing_styles.dart';
import 'package:weather_app/common/utils/helpers/helper.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/presentation/widgets/weatherScreenWidgets/aqi_widget.dart';
import 'package:weather_app/presentation/widgets/weatherScreenWidgets/feels_humd.dart';
import 'package:weather_app/presentation/widgets/weatherScreenWidgets/sunset.dart';
import 'package:weather_app/presentation/widgets/weatherScreenWidgets/visibility&pressure.dart';
import 'package:weather_app/presentation/widgets/weatherScreenWidgets/weather_header.dart';
import 'package:weather_app/presentation/widgets/weatherScreenWidgets/wind.dart';

class WeatherScreen extends StatelessWidget {
  final Weather weather;

  const WeatherScreen({super.key, required this.weather});


  String formatTimeFromUnix(int utcTimestamp, int timezoneOffsetInSeconds) {
    final localTime = DateTime.fromMillisecondsSinceEpoch(
      (utcTimestamp + timezoneOffsetInSeconds) * 1000,
      isUtc: true,
    );
    return DateFormat('hh:mm a').format(localTime);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Padding(
        padding: AppSpacingStyles.paddingWithAppBarHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              WeatherHeader(
                isDark: isDark,
                city: weather.name,
                temp: weather.main.temp.round(),
                condition: weather.weather.first.description,
                high: weather.main.tempMax.round(),
                low: weather.main.tempMin.round(),
              ),

              
              const SizedBox(height: 30),
              AQIWidget(
                isDark: isDark,
                aqiValue: 42.0, 
              ),

              const SizedBox(height: 20),
              FeelsHumd(
                feelsLike: weather.main.feelsLike.round(),
                temp: weather.main.temp.round(),
                humidity: weather.main.humidity,
                isDark: isDark,
              ),

              const SizedBox(height: 8),

              WindWidget(
                speed: weather.wind.speed,
                deg: weather.wind.deg.toDouble(),
                gust: weather.wind.gust,
                isDark: isDark,
              ),

              const SizedBox(height: 20),
              
              VisibilityPressure(
                visibility: weather.visibility / 1000,
                pressure: weather.main.pressure,
                isDark: isDark,
              ),
              const SizedBox(height: 20),
              SunPathWidget(
                sunriseTime: formatTimeFromUnix(weather.sys.sunrise, weather.timezone),
                sunsetTime: formatTimeFromUnix(weather.sys.sunset, weather.timezone),
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
