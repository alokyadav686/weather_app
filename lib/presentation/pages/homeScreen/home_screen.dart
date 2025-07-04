import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/common/styles/spacing_styles.dart';
import 'package:weather_app/common/utils/helpers/helper.dart';
import 'package:weather_app/presentation/controllers/weather_controller.dart';
import 'package:weather_app/presentation/widgets/homeScreenWidgets/weather_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    final WeatherController weatherController = Get.put(WeatherController());

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Weather",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Icon(Icons.menu, color: isDark ? Colors.white : Colors.black),
          ],
        ),
      ),
      body: Padding(
        padding: AppSpacingStyles.sidePadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Search field
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a city',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  filled: true,
                  fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                onChanged: (String input) {
                  if (input.isNotEmpty) {
                    weatherController.city.value = input;
                    weatherController.weatherList.clear();
                    weatherController.fetchWeather();
                  }
                },
              ),

              const SizedBox(height: 20),

              // Weather summary card
              Obx(
                () =>
                    weatherController.weatherList.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                          itemCount: weatherController.weatherList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final weather =
                                weatherController.weatherList[index];
                            return WeatherCard(
                              city: weather.name,
                              temp: weather.main.temp.round(),
                              condition: weather.weather.first.description,
                              high: weather.main.tempMax.round(),
                              low: weather.main.tempMin.round(),
                              isDark: isDark,
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
