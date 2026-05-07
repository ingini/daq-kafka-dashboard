import 'package:daq_dashboard/src/Controllers/CameraController.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/CameraModel.dart';
import 'package:daq_dashboard/src/store/constant.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/CameraWidget.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'ImageCanvasConsumeGateWay.dart';
import 'ImageCanvasConsumeWidget.dart';
import 'package:daq_dashboard/src/widgets/CameraWidget.dart';




class RearCameraWidget extends CameraWidget {
  RearCameraWidget(eTags taggingTag) : super(taggingTag);

  @override
  _RearCameraWidgetState createState() => _RearCameraWidgetState(taggingMetaProperty);
}




class _RearCameraWidgetState extends CameraWidgetState {
  _RearCameraWidgetState(metaProperty taggingMetaProperty) : super(taggingMetaProperty);


  // bool isFlipped = false;
  //
  // void toggleFlip() {
  //   setState(() {
  //     isFlipped = !isFlipped;
  //     print("isFlipped : $isFlipped");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //
    // final CameraController controller = Get.find(tag: tag);
    //
    // print("RearCameraWidget build _ ${controller.getIsFlipped()}");


    return Stack(
      children:[
        super.build(context),
        Positioned(
          top: 13.h,
          right: 70.w,
          child: GetBuilder<CameraController> (
              tag: tag,
              builder: (CameraController controller) {
               return UIComponents.imageFlipStatusIcon(controller.getIsFlipped());
            }
          ),
        ),
      ]
    );

  }
}