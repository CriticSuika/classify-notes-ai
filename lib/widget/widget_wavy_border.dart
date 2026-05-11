import 'package:flutter/material.dart';

class WavyBorderPainter extends CustomPainter {
  final Color _borderColor;

  WavyBorderPainter(this._borderColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();

    double waveWidth = 20;
    double waveHeight = 5;

    path.moveTo(0, 0);
    for (double i = 0; i < size.width; i += waveWidth) {
      path.relativeQuadraticBezierTo(
        waveWidth / 4, -waveHeight,
        waveWidth / 2, 0,
      );
      path.relativeQuadraticBezierTo(
        waveWidth / 4, waveHeight,
        waveWidth / 2, 0,
      );
    }

    path.moveTo(size.width, 0);
    for (double i = 0; i < size.height; i += waveWidth) {
      path.relativeQuadraticBezierTo(
        -waveHeight, waveWidth / 4,
        0, waveWidth / 2,
      );
      path.relativeQuadraticBezierTo(
        waveHeight, waveWidth / 4,
        0, waveWidth / 2,
      );
    }

    path.moveTo(size.width, size.height);
    for (double i = 0; i < size.width; i += waveWidth) {
      path.relativeQuadraticBezierTo(
        -waveWidth / 4, waveHeight,
        -waveWidth / 2, 0,
      );
      path.relativeQuadraticBezierTo(
        -waveWidth / 4, -waveHeight,
        -waveWidth / 2, 0,
      );
    }

    path.moveTo(0, size.height);
    for (double i = 0; i < size.height; i += waveWidth) {
      path.relativeQuadraticBezierTo(
        waveHeight, -waveWidth / 4,
        0, -waveWidth / 2,
      );
      path.relativeQuadraticBezierTo(
        -waveHeight, -waveWidth / 4,
        0, -waveWidth / 2,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
