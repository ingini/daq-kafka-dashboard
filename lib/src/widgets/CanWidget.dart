import 'package:daq_dashboard/src/Controllers/CanController.dart';
import 'package:daq_dashboard/src/Controllers/LidarController.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/CanModel.dart';
import 'package:daq_dashboard/src/Models/LidarModel.dart';
import 'package:daq_dashboard/src/store/constant.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/ImageCanvasConsumeGateWay.dart';
import 'package:daq_dashboard/src/widgets/ImageCanvasConsumeWidget.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';


class CanWidget extends TaggingStatefulWidget {

  CanWidget( eTags taggingTag ) : super(taggingTag: taggingTag);

  @override
  TaggingWidgetState<CanWidget> createState() =>  _CanWidgetState(taggingMetaProperty);

}

class _CanWidgetState extends TaggingWidgetState<CanWidget> {

  _CanWidgetState(metaProperty taggingMetaProperty) : super(taggingMetaProperty);

  @override
  Widget build(BuildContext context) {
    final UIColors uiColors = Theme.of(context).extension<UIColors>()!;

    return GetBuilder<CanController>(
        tag: tag,
        builder: (CanController controller) {

          CanModel? model = controller.getModel() as CanModel?;

          if(model == null) {
            print("model Null");
          }

          return GestureDetector(

            onTap:() async {
              // 여기에 클릭 시 실행할 controller의 함수 호출
              controller.OnTapWidget(); // 여기서 yourFunction을 controller의 실제 함수로 변경
            },

            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                padding: EdgeInsets.all(16.0),

                child: Column(
                  children: [

                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                              child: Container(
                                  child: UIComponents.sensorConnectionStateIcon( model!.connection_state ),
                              )
                          ),
                          Expanded(
                              flex: 3,
                              child: Container(),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: UIComponents.sensorAcquiringIcon( model!.acquisition_state ),
                              )
                          ),
                        ]
                      )
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UIComponents.textWidget("CAN"),
                          SizedBox(height: 15.h),
                          UIComponents.textWidget("${model.bytes_per_sec==null?"--":model.bytes_per_sec} KB/s"),
                          SizedBox(height: 40.h,)
                        ],
                      ),

                    ),
                  ],
                ),

              ),
            ),
          );
          //
          //
          // return Stack(
          //   children: [
          //     Positioned.fill(
          //       child: FractionallySizedBox(
          //           widthFactor: 1, // 100% 폭
          //           heightFactor: 1, // 100% 높이
          //           child: Card(
          //             color: Theme.of(context).colorScheme.surface,
          //             child: ImageCanvasConsumeWidget(controller,tag),
          //           )
          //       ),
          //     ),
          //     Positioned(
          //       left: 0,
          //       right: 0,
          //       child:Container(
          //         height: 30,
          //         decoration: BoxDecoration(
          //           color: (model!.IsStateSuccess(eProcessingState.SensorConnected)
          //               ? uiColors.success
          //               : uiColors.closed)?.withOpacity(0.8),
          //           borderRadius: BorderRadius.circular(buttonBorderRadius),
          //         ),
          //         padding: EdgeInsets.all(1.0),
          //         child: Row(
          //           mainAxisSize: MainAxisSize.min,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Expanded(
          //               child: Text(
          //                 taggingMetaProperty.display_name,
          //                 style: Theme.of(context).textTheme.titleMedium,
          //               ),
          //             ),
          //             if (!model.IsStateSuccess(eProcessingState.SensorHealthy))
          //               Image.asset(
          //                 'assets/img/sensor_out.png',
          //                 width: 20,
          //                 height: 20,
          //               ),
          //           ],
          //         ),
          //       ),
          //       //
          //       // ElevatedButton(
          //       //     onPressed: () => {},
          //       //     style: ElevatedButton.styleFrom(
          //       //         backgroundColor: uiColors.success,
          //       //         shape: RoundedRectangleBorder(
          //       //             borderRadius: BorderRadius.circular(buttonBorderRadius)
          //       //         )
          //       //     ),
          //       //     child: Text(_tag, style: Theme.of(context).textTheme.titleLarge)
          //       // )
          //     ),
          //     // Align(
          //     //   alignment: Alignment.topRight,
          //     //   child: Text(
          //     //     'widget.viewModel.device.viewStatus' + '  ',// == LoggingStatus.ERROR ? 'Error !' : '',
          //     //     textAlign: TextAlign.center,
          //     //     style: TextStyle(fontWeight: FontWeight.bold),
          //     //   ),
          //     // ),
          //
          //     Align(
          //       alignment: Alignment.bottomRight,
          //       child: Text(
          //         //widget.viewModel.device.loggingStatus == LoggingStatus.ERROR ? 'Error !' : '',
          //         model.GetAcquiringStr(),
          //         textAlign: TextAlign.center,
          //         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          //       ),
          //     ),
          //     // 이부분에 controller 의 특정 상태에 따라서 애니메이션 아이콘 (사용자기 만든)을 보여주고 싶은데 방법은?
          //
          //     Align(
          //       alignment: Alignment(-1.05, -0.9),  // 더 아래로 배치
          //       child: IconButton(
          //         onPressed: () => {
          //           model.IsAcquiring() ? controller.StopSensorAcquisition() : controller.StartSensorAcquisition(),
          //         },
          //         iconSize: 48.0,  // 버튼의 크기를 키움
          //         icon: Icon(
          //           model.IsAcquiring() ? Icons.stop : Icons.play_arrow,
          //         ),
          //       ),
          //     ),
          //   ],
          // );
        }
    );
  }
}


