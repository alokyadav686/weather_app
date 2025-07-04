import 'package:flutter/material.dart';
import 'package:weather_app/common/utils/contants/text_constants.dart';

class AQIWidget extends StatelessWidget {
  final bool isDark;
  final double aqiValue;

  const AQIWidget({super.key, required this.isDark, required this.aqiValue});

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width - 40;
    final dotPos = (aqiValue.clamp(0, 500) / 500) * totalWidth;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            const BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.air, size: 30, color: isDark ? Colors.white : Colors.blue),
              const SizedBox(width: 10),
              Text(AppTextConstants.aqiLabel, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("AQI: ${aqiValue.toInt()}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                child: const Text("Good", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Air quality is considered satisfactory, and air pollution poses little or no risk.",
            style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black87),
          ),
          const SizedBox(height: 16),

          // AQI bar with dot
          Stack(
            children: [
              Row(
                children: [
                  _aqiSegment(Colors.green, isStart: true),
                  _aqiSegment(Colors.yellow),
                  _aqiSegment(Colors.orange),
                  _aqiSegment(Colors.red),
                  _aqiSegment(Colors.purple),
                  _aqiSegment(Colors.brown),
                  _aqiSegment(Colors.grey, isEnd: true),
                ],
              ),
              Positioned(
                left: dotPos.clamp(0, totalWidth - 12),
                top: -3,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black.withOpacity(0.4), width: 1.5),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 1))],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aqiSegment(Color color, {bool isStart = false, bool isEnd = false}) {
    return Expanded(
      child: Container(
        height: 8,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.horizontal(
            left: isStart ? const Radius.circular(8) : Radius.zero,
            right: isEnd ? const Radius.circular(8) : Radius.zero,
          ),
        ),
      ),
    );
  }
}
