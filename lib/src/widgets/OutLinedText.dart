



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OutLinedText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final Color outlineColor;
  final double outlineWidth;

  OutLinedText({
    required this.text,
    required this.size,
    required this.color,
    this.outlineColor = Colors.black,
    this.outlineWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Outline
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = outlineWidth
              ..color = outlineColor,
            decoration: TextDecoration.none,
          ),
        ),
        // Main text
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            color: color,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}