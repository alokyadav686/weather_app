import 'package:flutter/material.dart';
import 'package:weather_app/common/utils/theme/themes.dart';
import 'package:get/get.dart';
import 'package:weather_app/presentation/pages/homeScreen/home_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // initialBinding: HomeBinding(),
      // getPages: [
      //   GetPage(
      //     name: '/home',
      //     page: () => const HomeScreen(),
      //     binding: HomeBinding(),
      //   ),
        // Add others here
      // ],

      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
