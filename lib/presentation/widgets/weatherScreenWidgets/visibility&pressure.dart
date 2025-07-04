import 'package:flutter/material.dart';

class VisibilityPressure extends StatelessWidget {
  final double visibility;
  final int pressure;
  final bool isDark;

  const VisibilityPressure({
    super.key,
    required this.visibility,
    required this.pressure,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color subTextColor = isDark ? Colors.grey[300]! : Colors.grey[600]!;
    final Color tileColor = isDark ? Colors.grey[850]! : Colors.grey[100]!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDataTile(
          label: "Visibility",
          value: "${visibility.toStringAsFixed(1)} km",
          icon: Icons.remove_red_eye_outlined,
          tileColor: tileColor,
          textColor: textColor,
          subTextColor: subTextColor,
        ),
        _buildDataTile(
          label: "Pressure",
          value: "$pressure hPa",
          icon: Icons.speed,
          tileColor: tileColor,
          textColor: textColor,
          subTextColor: subTextColor,
        ),
      ],
    );
  }

  Widget _buildDataTile({
    required String label,
    required String value,
    required IconData icon,
    required Color tileColor,
    required Color textColor,
    required Color subTextColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      width: 160,
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: textColor.withOpacity(0.8), size: 28),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: textColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: subTextColor.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
