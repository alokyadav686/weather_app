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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // 🔍 Search bar
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
                onChanged: weatherController.onSearchChanged,
              ),

              const SizedBox(height: 10),

              // 📝 Suggestions
              Obx(() {
                final suggestions = weatherController.filteredCities;
                return suggestions.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: suggestions.length,
                        itemBuilder: (context, index) {
                          final city = suggestions[index];
                          return ListTile(
                            title: Text(
                              city,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            onTap: () =>
                                weatherController.onCitySelected(city),
                          );
                        },
                      )
                    : const SizedBox();
              }),

              const SizedBox(height: 20),

              // 🌤️ Weather Cards
              Obx(() {
                final weatherList = weatherController.weatherList;
                if (weatherList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: weatherList.length,
                  itemBuilder: (context, index) {
                    final weather = weatherList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: WeatherCard(
                        city: weather.name,
                        temp: weather.main.temp.round(),
                        condition: weather.weather.first.description,
                        high: weather.main.tempMax.round(),
                        low: weather.main.tempMin.round(),
                        isDark: isDark,
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
