import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class GradientCircularLoader extends StatefulWidget {
  final double size;
  final Color leadingColor;
  final Color trailingColor;
  final Duration duration;
  final double strokeWidth;

  const GradientCircularLoader({
    super.key,
    required this.size,
    required this.leadingColor,
    required this.trailingColor,
    this.duration = const Duration(milliseconds: 1500),
    required this.strokeWidth,
  });

  @override
  State<GradientCircularLoader> createState() => _GradientCircularLoaderState();
}

class _GradientCircularLoaderState extends State<GradientCircularLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CustomPaint(
            painter: _GradientArcPainter(
              strokeWidth: widget.strokeWidth,
              rotation: _controller.value,
              leadingColor: widget.leadingColor,
              trailingColor: widget.trailingColor,
            ),
          );
        },
      ),
    );
  }
}

class _GradientArcPainter extends CustomPainter {
  final double rotation;
  final Color leadingColor;
  final Color trailingColor;
  final double strokeWidth;

  _GradientArcPainter({
    required this.strokeWidth,
    required this.rotation,
    required this.leadingColor,
    required this.trailingColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = size.center(Offset.zero);
    final radius = (size.width - strokeWidth) / 2;

    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: pi * 2,
      colors: [leadingColor, trailingColor],
      stops: [0.0, 1.0],
      transform: GradientRotation(2 * pi * rotation),
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..shader = gradient
          .createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _GradientArcPainter oldDelegate) => true;
}
