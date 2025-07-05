import 'package:flutter/material.dart';

class WindWidget extends StatelessWidget {
  final double speed;
  final double deg;
  final double gust;
  final bool isDark;

  const WindWidget({
    super.key,
    required this.speed,
    required this.deg,
    required this.gust,
    required this.isDark,
  });

  String getCompassDirection(double degree) {
    const directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"];
    return directions[((degree + 22.5) / 45).floor() % 8];
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors =
        isDark
            ? [Colors.blueGrey.shade800, Colors.black87]
            : [Colors.blue.shade100, Colors.white];

    final textColor = isDark ? Colors.white : Colors.black87;
    final tileColor = isDark ? Colors.white10 : Colors.white.withOpacity(0.7);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black54 : Colors.blue.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wind_power, color: textColor, size: 22),
              const SizedBox(width: 8),
              Text(
                "Wind Conditions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Wind Values
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatTile(
                "Speed",
                "${speed.toStringAsFixed(1)} m/s",
                Icons.speed,
                textColor,
                tileColor,
              ),
              _buildStatTile(
                "Gust",
                "${gust.toStringAsFixed(1)} m/s",
                Icons.air,
                textColor,
                tileColor,
              ),
              _buildStatTile(
                "Dir",
                "${getCompassDirection(deg)}\n(${deg.toInt()}°)",
                Icons.explore,
                textColor,
                tileColor,
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Decorative wind icon (can replace with animated Lottie later)
          Icon(Icons.air_outlined, size: 80, color: textColor.withOpacity(0.3)),
        ],
      ),
    );
  }

  Widget _buildStatTile(
    String label,
    String value,
    IconData icon,
    Color textColor,
    Color bgColor,
  ) {
    return Container(
      width: 90,
      height: 130,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: textColor.withOpacity(0.8), size: 24),
          const SizedBox(height: 10),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
