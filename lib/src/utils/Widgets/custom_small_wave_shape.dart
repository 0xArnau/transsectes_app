import 'package:flutter/material.dart';
import 'package:transsectes_app/src/utils/colors.dart';

Widget CustomSmallWaveShape(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: MediaQuery.of(context).size.height /
        4, // Un cuarto de la altura de la pantalla
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
      ..moveTo(0, size.height - size.height / 1.8) // Comienza desde abajo
      ..quadraticBezierTo(
        size.width / 5,
        size.height - size.height / 2.2,
        size.width / 3,
        size.height - size.height / 1.8,
      )
      ..quadraticBezierTo(
        size.width / 2,
        size.height - size.height / 1.4,
        size.width * 0.65,
        size.height -
            size.height /
                1.8, // Ajuste para crear el hundimiento en el lado derecho
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height - size.height / 2.2,
        size.width,
        size.height - size.height / 1.8, // Termina en el lado derecho
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
