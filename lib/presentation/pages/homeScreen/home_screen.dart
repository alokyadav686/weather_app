import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/common/styles/spacing_styles.dart';
import 'package:weather_app/common/utils/contants/text_constants.dart';
import 'package:weather_app/common/utils/helpers/helper.dart';
import 'package:weather_app/presentation/controllers/weather_controller.dart';
import 'package:weather_app/presentation/widgets/homeScreenWidgets/weather_card.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    final WeatherController weatherController = Get.put(WeatherController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: isDark ? Colors.blueGrey[900] : Colors.blue.shade100,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppTextConstants.homeScreenTitle,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.dialog(_ManageWeatherDialog(isDark: isDark));
                },
                child: Icon(
                  Icons.menu,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  isDark
                      ? [Colors.blueGrey[900]!, Colors.blueGrey[800]!]
                      : [Colors.blue.shade100, Colors.blue.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: AppSpacingStyles.sidePadding,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  TextField(
                    decoration: InputDecoration(
                      hintText: AppTextConstants.searchHint,
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
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    onChanged: weatherController.onSearchChanged,
                  ),

                  const SizedBox(height: 10),

                  Obx(() {
                    final suggestions = weatherController.filteredCities;
                    return suggestions.isNotEmpty
                        ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              suggestions.length > 3 ? 3 : suggestions.length,
                          itemBuilder: (context, index) {
                            final city = suggestions[index];
                            return ListTile(
                              title: Text(
                                city,
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              onTap:
                                  () => weatherController.onCitySelected(city),
                            );
                          },
                        )
                        : const SizedBox();
                  }),

                  const SizedBox(height: 20),

                  Obx(() {
                    final weatherList = weatherController.weatherList;
                    if (weatherList.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.asset(
                                'assets/lottie/cloudy.json',
                                width: 150,
                                height: 150,
                                fit: BoxFit.contain,
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                "Looking up the skies...",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const SizedBox(height: 12),

                              const CircularProgressIndicator(),

                              const SizedBox(height: 24),

                              const Text(
                                "Add a city to get started!",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: weatherList.length,
                      itemBuilder: (context, index) {
                        final weather = weatherList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: WeatherCard(weather: weather, isDark: isDark),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ManageWeatherDialog extends StatelessWidget {
  final bool isDark;
  final WeatherController controller = Get.find();

  _ManageWeatherDialog({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      title: Text(
        'Manage Weather Cards',
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Obx(() {
          final cities = controller.weatherList;
          if (cities.isEmpty) {
            return Text(
              "No cities added yet.",
              style: TextStyle(color: isDark ? Colors.white60 : Colors.black54),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final weather = cities[index];
              return ListTile(
                title: Text(
                  weather.name,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    controller.removeCity(weather.name);

                    Get.snackbar(
                      "Removed",
                      "${weather.name} removed successfully.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withOpacity(0.8),
                      colorText: Colors.white,
                    );
                  },
                ),
              );
            },
          );
        }),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Close")),
      ],
    );
  }
}
