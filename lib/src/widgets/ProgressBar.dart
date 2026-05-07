import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressBar extends StatelessWidget {
  final double height;   // min 30

  final double? proccing_percent;   // min 30

  final Color bg_color;
  final Color bar_color;

  ProgressBar({
    required this.proccing_percent,
    required this.bg_color,
    required this.bar_color,
    this.height = 30,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: height, // 높이 조정
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white!,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10 - 4),
        child: LinearProgressIndicator(
          value: proccing_percent, // 용량 비율
          backgroundColor: bg_color,
          valueColor: AlwaysStoppedAnimation<Color>(bar_color),
        ),
      ),
    );
  }




}