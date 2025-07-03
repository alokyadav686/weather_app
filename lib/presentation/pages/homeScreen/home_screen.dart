import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/common/styles/spacing_styles.dart';
import 'package:weather_app/common/utils/helpers/helper.dart';
import 'package:weather_app/presentation/controllers/home_controller.dart';
import 'package:weather_app/presentation/widgets/homeScreenWidgets/weather_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Align(
          alignment: Alignment.topRight,
          child: Icon(Icons.menu, color: isDark ? Colors.white : Colors.black),
        ),
      ),
      body: Padding(
        padding: AppSpacingStyles.sidePadding,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Weather",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
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
              onChanged: controller.onCitySearch,
            ),

            const SizedBox(height: 20),

            // Weather summary card
            Obx(() => WeatherCard(
                  city: controller.city.value,
                  temp: controller.temp.value,
                  condition: controller.condition.value,
                  high: controller.high.value,
                  low: controller.low.value,
                  isDark: isDark,
                )),
          ],
        ),
      ),
    );
  }
}
