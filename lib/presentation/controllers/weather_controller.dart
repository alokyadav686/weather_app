import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/common/utils/contants/api_constants.dart';
import 'package:weather_app/data/models/weather.dart';

class WeatherController extends GetxController {
  var weatherList = <Weather>[].obs;
  var t = 2.obs;
  var isLoading = true.obs;
  var city = 'hazaribagh'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWeather();
  }

  

  Future<Object> getWeather() async {
    var response = await http.get(
      Uri.parse(
        '${APIConstants.baseUrl}${city.value}&appid=${APIConstants.apiKey}&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return weatherFromJson(jsonString);
    } else {
      return [];
    }
  }

  void fetchWeather() async {
    var weatherData = await getWeather();

    if (weatherData is Weather) {
      weatherList.add(weatherData);
      print('Weather data fetched successfully');
    } else if (weatherData is List<Weather>) {
      weatherList.addAll(weatherData);
    } else {
      print('Error fetching weather data');
    }
  }
}
