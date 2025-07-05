import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/common/utils/contants/api_constants.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

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
          allCities
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

  var allCities = <String>[
  // Indian Cities
  'Delhi',
  'Mumbai',
  'Kolkata',
  'Chennai',
  'Bangalore',
  'Hyderabad',
  'Pune',
  'Hazaribagh',
  'Ranchi',
  'Patna',
  'Cherrapunji',
  'Shillong',
  'Lucknow',
  'Kanpur',
  'Ghaziabad',
  'Noida',
  'Chandigarh',
  'Ahmedabad',
  'Jaipur',
  'Surat',
  'Bhopal',
  'Indore',
  'Nagpur',
  'Thane',
  'Visakhapatnam',
  'Vijayawada',
  'Varanasi',
  'Guwahati',
  'Raipur',
  'Jamshedpur',
  'Dhanbad',
  'Bhubaneswar',
  'Cuttack',
  'Agra',
  'Meerut',
  'Prayagraj',
  'Amritsar',
  'Ludhiana',
  'Jalandhar',
  'Dehradun',
  'Haridwar',
  'Shimla',
  'Panaji',
  'Mysore',
  'Mangalore',
  'Kozhikode',
  'Thiruvananthapuram',
  'Kochi',
  'Coimbatore',
  'Madurai',
  'Tiruchirappalli',
  'Salem',
  'Udaipur',
  'Ajmer',
  'Gwalior',
  'Jhansi',
  'Aligarh',
  'Moradabad',
  'Bareilly',
  'Siliguri',
  'Darjeeling',
  'Nashik',
  'Aurangabad',
  'Latur',
  'Kolhapur',
  'Satara',
  'Belgaum',
  'Hubli',
  'Gulbarga',
  'Warangal',
  'Nellore',
  'Kurnool',
  'Anantapur',
  'Rajahmundry',
  'Tirupati',
  'Bilaspur',
  'Korba',
  'Silchar',
  'Aizawl',
  'Itanagar',
  'Imphal',
  'Kohima',
  'Gangtok',
  'Port Blair',
  'Puducherry',
  'Diu',
  'Daman',
  'Kavaratti',
  'Rewa',
  'Katni',
  'Sagar',
  'Satna',
  'Begusarai',
  'Arrah',
  'Sasaram',
  'Hajipur',
  'Samastipur',
  'Gaya',
  'Motihari',
  'Siwan',
  'Bhagalpur',
  'Muzaffarpur',
  'Chhapra',
  'Bokaro Steel City',
  'Palamu',
  'Daltonganj',
  'Chaibasa',
  'Lohardaga',
  'Dumka',
  'Giridih',
  'Godda',
  'Latehar',
  'Ramgarh',
  'Medininagar',

  // Newly Added Indian Tourist & Remote Cities
  'Leh',
  'ladakh',
  'Manali',
  'Kargil',
  'Zanskar',
  'Pahalgam',
  'Gulmarg',
  'Sonmarg',
  'Nainital',
  'Mussoorie',
  'Mount Abu',
  'Khandala',
  'Lonavala',
  'Mahabaleshwar',
  'Panchgani',
  'Rishikesh',
  'Auli',
  'Spiti',
  'Keylong',
  'Tawang',
  'Bomdila',
  'Chopta',
  'Binsar',
  'Almora',
  'Majuli',
  'Ziro',
  'Chamba',
  'Kasauli',
  'Khajuraho',
  'Konark',
  'Hampi',
  'Badami',
  'Rameswaram',
  'Kanyakumari',
  'Dharamshala',
  'McLeod Ganj',
  'Palampur',
  'Andro',
  'Yuksom',
  'Nongpoh',

  // Global High-Density and Tourist Cities
  'Tokyo',
  'New York City',
  'London',
  'Paris',
  'Bangkok',
  'Hong Kong',
  'Singapore',
  'Dubai',
  'Istanbul',
  'Rome',
  'Barcelona',
  'Seoul',
  'Shanghai',
  'Beijing',
  'Moscow',
  'Cairo',
  'Rio de Janeiro',
  'Mexico City',
  'Los Angeles',
  'San Francisco',
  'Toronto',
  'Sydney',
  'Melbourne',
  'Kuala Lumpur',
  'Amsterdam',
  'Venice',
  'Berlin',
  'Prague',
  'Vienna',
  'Zurich',
  'Lisbon',
  'Dhaka',
  'Jakarta',
  'Tehran',
  'Lagos',
  'Manila',
  'Karachi',
  'Lahore',
  'Colombo',
  'Kathmandu',
  'Tashkent',
  'Doha',
  'Muscat',
  'Reykjavik',
  'Oslo',
  'Helsinki',
  'Copenhagen',
  'Brussels',
  'Warsaw',
  'Budapest',
  'Edinburgh',
  'Nice',
  'Marrakech',
  'Cape Town',
];

}
