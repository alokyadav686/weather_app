import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/common/utils/contants/api_constants.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/presentation/controllers/home_controller.dart';

class WeatherController extends GetxController {
  var weatherList = <Weather>[].obs;
  var city = ''.obs;

  String getWeatherAnimation(String description) {
    if (description.contains("clear")) {
      return 'assets/lottie/clear.json';
    } else if (description.contains("cloud")) {
      return 'assets/lottie/cloud.json';
    } else if (description.contains("light rain") ||
        description.contains("moderate rain") ||
        description.contains("drizzle")) {
      return 'assets/lottie/rain.json';
    } else if (description.contains("heavy rain") ||
        description.contains("torrential rain")) {
      return 'assets/lottie/thunder.json';
    } else if (description.contains("thunder")) {
      return 'assets/lottie/thunder.json';
    } else if (description.contains("snow")) {
      return 'assets/lottie/snow.json';
    } else if (description.contains("mist") || description.contains("fog")) {
      return 'assets/lottie/mist.json';
    } else {
      return 'assets/lottie/clear.json';
    }
  }

  String getWeatherBackground(String description) {
    if (description.contains("clear")) {
      return 'assets/images/clear.png';
    } else if (description.contains("cloud")) {
      return 'assets/images/day.png';
    } else if (description.contains("rain") || description.contains("thunder")) {
      return 'assets/images/rain.png';
    } else if (description.contains("snow" ) ||
               description.contains("sleet") ||
               description.contains("hail")) {
      return 'assets/images/snow.png';
    } else {
      return 'assets/images/clear.png';
    }
  }



  var filteredCities = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    fetchWeather();
  }

  Future<Object> getWeather() async {
    final url =
        '${APIConstants.baseUrl}${city.value}&appid=${APIConstants.apiKey}&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return weatherFromJson(response.body);
    } else {
      return [];
    }
  }

  void fetchWeather() async {
    final normalizedCity = city.value.trim().toLowerCase();
    // print("this is normlized city $normalizedCity");

    final alreadyExists = weatherList.any(
      (w) => w.name.trim().toLowerCase() == normalizedCity,
    );

    if (alreadyExists) {
      Get.snackbar(
        "Already Added",
        "${city.value.trim()} is already in the list.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    var weatherData = await getWeather();
    if (weatherData is Weather) {
      weatherList.add(weatherData);

      Get.snackbar(
        "City Added",
        "${weatherData.name} weather added successfully.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Error",
        "Failed to fetch weather data.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      filteredCities.clear();
    } else {
      filteredCities.value =
          HomeController().allCities
              .where((c) => c.toLowerCase().contains(query.toLowerCase()))
              .toList();
    }
  }

  void onCitySelected(String selectedCity) {
    city.value = selectedCity;
    filteredCities.clear();
    fetchWeather();
  }

  void removeCity(String cityName) {
    weatherList.removeWhere(
      (w) => w.name.toLowerCase() == cityName.toLowerCase(),
    );
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          String? cityName =
              placemarks.first.locality ??
              placemarks.first.subAdministrativeArea;

          if (cityName != null && cityName.isNotEmpty) {
            city.value = cityName;
            fetchWeather();
            return;
          }
        }

        Get.snackbar(
          "Location Error",
          "Could not determine city from location.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      } catch (e) {
        Get.snackbar(
          "Error",
          "Failed to fetch location data.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
    }
  }


}
