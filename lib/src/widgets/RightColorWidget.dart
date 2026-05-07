
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RightColorWidget extends StatefulWidget {
  RightColorWidget({Key? key}) : super(key: key);

  @override
  RightColorWidgetState createState() => RightColorWidgetState();
}

class RightColorWidgetState extends State<RightColorWidget> {
  Color _color = Colors.green;

  void onButtonDown(int keyCode) {

    print("RightColorWidgetState :: ${keyCode}");

    const int KEYCODE_VOLUME_DOWN = 25; // 예시 키 코드
    if (keyCode == KEYCODE_VOLUME_DOWN) {
      setState(() {
        _color = _color == Colors.green ? Colors.orange : Colors.green;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: _color,
    );
  }
}