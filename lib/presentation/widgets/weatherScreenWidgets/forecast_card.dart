import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget {
  final bool isDark;

  const ForecastCard({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final color = isDark ? Colors.white : Colors.black;
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(60),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("12 AM", style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold)),
          Icon(Icons.cloud, size: 40, color: color),
          Text("19°", style: TextStyle(fontSize: 26, color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
