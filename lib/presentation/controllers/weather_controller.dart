import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/common/utils/contants/api_constants.dart';
import 'package:weather_app/data/models/weather.dart';

class WeatherController extends GetxController {
  var weatherData = {}.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWeather();
  }

  Future<Object> getWeather() async {
    var weather = await http.get(Uri.parse(APIConstants.weatherApiKey));

    if (weather.statusCode == 200) {
      var jsonString = weather.body;

      return welcomeFromJson(jsonString);
    } else {
      return [];
    }
  }

  void fetchWeather() async {
    var weathers = await getWeather();

    try {
      isLoading(true);
      weatherData.value = weathers as Map<String, dynamic>;
    } finally {
      isLoading(false);
    }
  }
}
