import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHelperFunctions {
  /// Match a string value with a predefined color
  static Color? getColor(String value) {
    switch (value.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'pink':
        return Colors.pink;
      case 'grey':
        return Colors.grey;
      case 'purple':
        return Colors.purple;
      default:
        return null;
    }
  }

  /// Show snackbar using GetX
  static void showSnackBar(String title, String message, {Color? bgColor}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: bgColor ?? Colors.black87,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  /// Show alert dialog using GetX
  static void showAlert(
    String title,
    String message, {
    VoidCallback? onConfirm,
  }) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
          if (onConfirm != null) onConfirm();
        },
        child: const Text('OK'),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text('Cancel'),
      ),
    );
  }

  /// Truncate text to a specified length and add ellipsis if needed
  static String truncateText(String text, int limit) {
    if (text.length <= limit) return text;
    return '${text.substring(0, limit)}...';
  }

  /// Check if current theme is dark
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  /// Get screen width
  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  /// Get screen height
  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }
}
