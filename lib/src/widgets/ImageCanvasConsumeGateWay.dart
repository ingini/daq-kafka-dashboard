




import 'dart:ui' as ui;

import 'package:daq_dashboard/src/Controllers/ImageController.dart';
import 'package:daq_dashboard/src/dtos/RowImageDTO.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ImageCanvasConsumeGateWay extends StatelessWidget {

  final String _tag;

  ImageCanvasConsumeGateWay(this._tag);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ImageController>(
        tag: _tag,
        builder: (ImageController controller) {

          RowImageDTO? imageDto = controller.PopRowImageDTO();

          print("Li >>>>>>>>>>> Repaint!!!");

          if (imageDto != null )
          {

            return CustomPaint(
              painter: ImagePainter(imageDto.rowIamge ),
              // size: Size.infinite,
              size: MediaQuery.of(context).size,
            );
          }
          else
          {
            print("Img Not~~~~~~~~~ [ $_tag ] RePaint!!");
            return Center(child: CircularProgressIndicator() );
          }
        }
    );
  }
}


class ImagePainter extends CustomPainter {
  final ui.Image image;

  ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    // 화면 폭에 맞추어 이미지의 비율을 계산합니다.
    double scale = size.width / image.width;

    // scale=0.7;
    // scale=0.115;

    // 새로운 폭과 높이를 계산합니다.
    double newWidth = image.width * scale;
    double newHeight = image.height * scale;

    // print("img Size : $newWidth .. $newHeight ");

    // newWidth = 320.0;
    // newHeight = 240.0;

    // 이미지의 중앙을 화면의 중앙에 맞추기 위한 offset을 계산합니다.
    final Offset offset = Offset(0, (size.height - newHeight) / 2);
    // 이미지를 화면에 꽉 차게 그리기 위한 Rect를 계산합니다.
    final srcRect = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dstRect = Rect.fromLTWH(offset.dx, offset.dy, newWidth, newHeight);

    var paint = Paint();

    // print("ImagePainter :: paint");


    // 이미지를 화면에 꽉 차게 그립니다.
    canvas.drawImageRect(image, srcRect, dstRect, paint);

    // canvas.drawRect(dstRect, paint);

    // canvas.drawImage(image, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is ImagePainter && oldDelegate.image != image;
  }
}