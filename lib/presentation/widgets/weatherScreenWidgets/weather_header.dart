import 'package:flutter/material.dart';

class WeatherHeader extends StatelessWidget {
  final bool isDark;

  const WeatherHeader({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final color = isDark ? Colors.white : Colors.black;
    final subColor = isDark ? Colors.white70 : Colors.black54;

    return Column(
      children: [
        Text("Ghaziabad", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 10),
        Text("25°C", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: color)),
        Text("Sunny", style: TextStyle(fontSize: 20, color: subColor)),
        Text("H: 30°C, L: 20°C", style: TextStyle(fontSize: 16, color: subColor, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
