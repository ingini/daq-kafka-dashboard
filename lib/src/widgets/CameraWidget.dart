import 'package:daq_dashboard/src/Controllers/CameraController.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/CameraModel.dart';
import 'package:daq_dashboard/src/store/constant.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'ImageCanvasConsumeGateWay.dart';
import 'ImageCanvasConsumeWidget.dart';

import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';



class CameraWidget extends TaggingStatefulWidget {
  CameraWidget( eTags taggingTag )
      : super(taggingTag: taggingTag);


  @override
  CameraWidgetState createState() => CameraWidgetState(taggingMetaProperty);
}


class CameraWidgetState extends TaggingWidgetState<CameraWidget> {
  CameraWidgetState(metaProperty taggingMetaProperty) : super(taggingMetaProperty);



  // bool isFlipped = false;


  @override
  Widget build(BuildContext context) {
    // final UIColors uiColors = Theme.of(context).extension<UIColors>()!;

    return GetBuilder<CameraController>(
      tag: tag,
      builder: (CameraController controller) {
        //
        CameraModel? model = controller.getModel() as CameraModel?;
        // print('model?.connection_status?.state: ${model?.connection_status?.state}');
        // print('model?.connection_status?.name: ${model?.connection_status?.name}');


        // model 은 사이클 돌때 만들었지만 여기에서 불러지는 stateStack 은 이및 초기화 되어
        // 있다
        // 사이클 마다 새로 생성을 해야 한다.

        if(model == null) {
          print("model Null");
        }
        // //
        // print( "ddddd : " + model!.stateStack.toString() );
        //
        // print("ME : ControlActive : " + model.IsStateSuccess(eProcessingState.ControlActive).toString());
        // print("ME : NetworkConnected : " + model.IsStateSuccess(eProcessingState.NetworkConnected).toString());
        // print("ME : SensorConnected : " + model.IsStateSuccess(eProcessingState.SensorConnected).toString());
        // print("ME : SensorHealthy : " + model.IsStateSuccess(eProcessingState.SensorHealthy).toString());
        // print("ME : Acquiring : " + model.IsStateSuccess(eProcessingState.Acquiring).toString());
        // print("ME : Snap : " + model.IsStateSuccess(eProcessingState.Snap).toString());
        // print("ME : Snap2: " + model.row_image.toString());


        return Stack(
          children: [
            GestureDetector(
              onTap: () async {
                controller.OnTapWidget();
              },
              child: Container(

                child: Stack(
                    children: [
                      Container(
                          color: Colors.black,
                          child: ImageCanvasConsumeWidget(controller, tag,is_flipped: controller.getIsFlipped())
                      ),
                      Positioned(
                        top: 11.h,
                        left: 12.w,
                        child: Container(
                            child: UIComponents.sensorConnectionStateIcon(model!.connection_state)
                        ),
                      ),
                      Positioned(
                        top: 11.h,
                        left: (59 + 12).h,
                        child: Container(
                            child: UIComponents.sensorHealthIcon(model.health_state)
                        ),
                      ),
                      Positioned(
                        top: 11.h,
                        right: 10.h,
                        child: Container(
                            child: UIComponents.sensorAcquiringIcon(model.acquisition_state)
                        ),
                      ),
                    ]
                ),
              ),
            ),

            // Positioned(
            //   bottom: 20,
            //   right: 20,
            //   child: FloatingActionButton(
            //     onPressed: toggleFlip,
            //     child: Icon(Icons.flip),
            //   ),
            // ),
          ],
        );



      }
    );
  }
}