


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OutLinedIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final double outlineWidth ;
  final Color outlineColor;

  OutLinedIcon({
    required this.icon,
    required this.color,
    required this.size,
    this.outlineWidth = 2,
    this.outlineColor = Colors.black
  });

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Stack(
        children: [
          // Outline
          Icon(
            icon,
            // size: size + outlineWidth * 2,
            size: size + 1 ,
            color: outlineColor,
          ),
          Icon(
            icon,
            // size: size + outlineWidth * 2,
            size: size + outlineWidth ,
            color: outlineColor,
          ),
          Icon(
            icon,
            // size: size + outlineWidth * 2,
            size: size + outlineWidth  + outlineWidth ,
            color: outlineColor,
          ),
          // Main icon
          Icon(
            icon,
            size: size,
            color: color,
          ),
        ],
      ),
    );
  }




}