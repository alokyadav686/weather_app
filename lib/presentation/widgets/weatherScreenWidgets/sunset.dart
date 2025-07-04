import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class SunPathWidget extends StatelessWidget {
  final String sunsetTime;
  final String sunriseTime;
  final bool isDark;

  const SunPathWidget({
    super.key,
    required this.sunsetTime,
    required this.sunriseTime,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color bgColor = isDark ? Colors.blueGrey[900]! : Colors.blue.shade100;

    final now = DateTime.now();
    final format = DateFormat('hh:mm a');
    final sunrise = format.parse(sunriseTime);
    final sunset = format.parse(sunsetTime);

    // Align sunrise and sunset to today
    final sunriseToday = DateTime(
      now.year,
      now.month,
      now.day,
      sunrise.hour,
      sunrise.minute,
    );
    final sunsetToday = DateTime(
      now.year,
      now.month,
      now.day,
      sunset.hour,
      sunset.minute,
    );

    final totalDuration = sunsetToday.difference(sunriseToday).inSeconds;
    final elapsed = now
        .difference(sunriseToday)
        .inSeconds
        .clamp(0, totalDuration);

    final sunPositionFactor =
        totalDuration == 0 ? 0.0 : elapsed / totalDuration;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Lottie.asset('assets/lottie/sun.json'),
              ),
              const SizedBox(width: 6),
              Text(
                'SUNSET',
                style: TextStyle(
                  fontSize: 14,
                  color: textColor.withOpacity(0.9),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            sunsetTime,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(double.infinity, 120),
                  painter: SunArcPainter(
                    sunColor: textColor,
                    progress: sunPositionFactor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Sunrise: $sunriseTime',
              style: TextStyle(
                fontSize: 16,
                color: textColor.withOpacity(0.85),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SunArcPainter extends CustomPainter {
  final Color sunColor;
  final double progress;

  SunArcPainter({required this.sunColor, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint arcPaint =
        Paint()
          ..color = sunColor.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.8;

    final Paint sunDotPaint =
        Paint()
          ..color = Colors.deepOrangeAccent
          ..style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;

    final Path arcPath =
        Path()
          ..moveTo(0, height)
          ..quadraticBezierTo(width / 2, 0, width, height);
    canvas.drawPath(arcPath, arcPaint);

    final double sunX = progress * width;
    final double sunY = _getArcY(sunX, width, height);

    final Offset sunCenter = Offset(sunX, sunY);
    canvas.drawCircle(sunCenter, 10, sunDotPaint);

    canvas.drawShadow(
      Path()..addOval(Rect.fromCircle(center: sunCenter, radius: 6)),
      Colors.white,
      6,
      true,
    );

    final Paint horizonPaint =
        Paint()
          ..color = sunColor.withOpacity(0.2)
          ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, height - 20),
      Offset(width, height - 20),
      horizonPaint,
    );
  }

  double _getArcY(double x, double width, double height) {
    final h = width / 2;
    final k = 0.0;
    final a = height / (h * h);
    final y = a * (x - h) * (x - h) + k;
    return y;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
