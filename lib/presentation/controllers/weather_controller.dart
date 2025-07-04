import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/common/utils/contants/api_constants.dart';
import 'package:weather_app/data/models/weather.dart';

class WeatherController extends GetxController {
  var weatherList = <Weather>[].obs;
  var city = 'Hazaribagh'.obs;

  var allCities = <String>[
    'Delhi', 'Mumbai', 'Kolkata', 'Chennai', 'Bangalore', 'Hyderabad',
    'Pune', 'Hazaribagh', 'Ranchi', 'Patna', 'Lucknow', 'Kanpur',
    'Ghaziabad', 'Noida', 'Chandigarh'
  ];

  var filteredCities = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
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
    
    final alreadyExists = weatherList.any((w) =>
        w.name.toLowerCase() == city.value.trim().toLowerCase());

    if (alreadyExists) {
      print("City already exists in the list.");
      return;
    }

    var weatherData = await getWeather();
    if (weatherData is Weather) {
      weatherList.add(weatherData);
    } else {
      print('Error fetching weather');
    }
  }

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      filteredCities.clear();
    } else {
      filteredCities.value = allCities
          .where((c) => c.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void onCitySelected(String selectedCity) {
    city.value = selectedCity;
    filteredCities.clear();
    fetchWeather();
  }
}
