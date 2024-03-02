import 'package:flutter/material.dart';
import 'package:transsectes_app/src/utils/colors.dart';

Widget CustomWaveShape(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: MediaQuery.of(context).size.height / 1.4,
    child: CustomPaint(
      painter: WavePainter(),
    ),
  );
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = kColorBackgroundWave
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, size.height / 2)
      ..quadraticBezierTo(
        size.width / 4,
        size.height / 1.5,
        size.width / 2,
        size.height / 2,
      )
      ..quadraticBezierTo(
        3 * size.width / 4,
        size.height / 3,
        size.width,
        size.height / 2,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
