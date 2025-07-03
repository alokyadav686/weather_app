import 'package:flutter/material.dart';
import 'package:weather_app/common/styles/spacing_styles.dart';
import 'package:weather_app/common/utils/helpers/helper.dart';
import 'package:weather_app/presentation/controllers/weather_controller.dart';
import 'package:weather_app/presentation/widgets/weatherScreenWidgets/aqi_widget.dart';
import 'package:weather_app/presentation/widgets/weatherScreenWidgets/forecast_section.dart';
import 'package:weather_app/presentation/widgets/weatherScreenWidgets/weather_header.dart';
import 'package:get/get.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);

    final WeatherController controller = Get.put(WeatherController());

    return Scaffold(
      body: Padding(
        padding: AppSpacingStyles.paddingWithAppBarHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              WeatherHeader(isDark: isDark),
              const SizedBox(height: 20),
              ForecastSection(isDark: isDark),
              const SizedBox(height: 20),
              AQIWidget(isDark: isDark, aqiValue: 42),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
