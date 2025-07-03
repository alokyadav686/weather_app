import 'package:get/get.dart';

class HomeController extends GetxController {
  var city = 'Ghaziabad'.obs;
  var temp = 25.obs;
  var condition = 'Sunny'.obs;
  var high = 14.obs;
  var low = 10.obs;

  void onCitySearch(String query) {
    // Optionally update city and trigger weather fetch
    city.value = query;
  }
}
