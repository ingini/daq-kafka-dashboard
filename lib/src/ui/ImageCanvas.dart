
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageCanvas extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return Center(child: CircularProgressIndicator());

    //
    // return Consumer<ImageRpcProvider>(
    //   builder: (context, imageRpcProvider, child) {
    //     // 현재 이미지가 있는지 확인하고 그림을 그리거나 로딩 인디케이터를 보여줍니다.
    //     final image = imageRpcProvider.currentImage;
    //     if (image != null) {
    //       return CustomPaint(
    //         painter: ImagePainter(image),
    //         size: Size.infinite,
    //       );
    //     } else {
    //       // 이미지가 로드되지 않았다면 로딩 인디케이터를 보여줍니다.
    //       return Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );



  }
}