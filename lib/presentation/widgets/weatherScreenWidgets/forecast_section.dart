import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/weatherScreenWidgets/forecast_card.dart';

class ForecastSection extends StatelessWidget {
  final bool isDark;

  const ForecastSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.blue[50],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Hourly forecast", style: TextStyle(fontSize: 18, color: isDark ? Colors.white70 : Colors.black)),
                Text("Weekly forecast", style: TextStyle(fontSize: 18, color: isDark ? Colors.white70 : Colors.black)),
              ],
            ),
            Divider(color: isDark ? Colors.white30 : Colors.black26),
            const SizedBox(height: 20),
            ForecastCard(isDark: isDark),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
