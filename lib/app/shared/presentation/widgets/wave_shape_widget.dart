import 'package:flutter/material.dart';

/// A widget that draws a wave shape with a custom painter.
class WaveShapeWidget extends StatelessWidget {
  const WaveShapeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 1.4,
      child: CustomPaint(
        painter: WavePainter(context), // Pass context to the painter
      ),
    );
  }
}

/// A custom painter that draws a wave shape on the canvas.
class WavePainter extends CustomPainter {
  final Color color;

  /// Constructor that accepts the primary container color from the theme.
  WavePainter(BuildContext context)
      : color = Theme.of(context).colorScheme.primaryContainer;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = _createWavePath(size);
    canvas.drawPath(path, paint);
  }

  /// Creates the wave path that will be drawn on the canvas.
  Path _createWavePath(Size size) {
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

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Return true if the painting needs to be updated dynamically
  }
}
