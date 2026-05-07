import 'package:daq_dashboard/src/Controllers/LidarGroupController.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/LidarGroupModel.dart';
import 'package:daq_dashboard/src/store/constant.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/ImageCanvasConsumeWidget.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';

class LidarGroupWidget extends TaggingStatefulWidget {

  LidarGroupWidget( eTags taggingTag ) : super(taggingTag: taggingTag);

  @override
  TaggingWidgetState<LidarGroupWidget> createState() =>  _LidarGroupWidgetState(taggingMetaProperty);

}


class _LidarGroupWidgetState extends TaggingWidgetState<LidarGroupWidget> {

  _LidarGroupWidgetState(metaProperty taggingMetaProperty) : super(taggingMetaProperty);

  @override
  Widget build(BuildContext context) {
    final UIColors uiColors = Theme.of(context).extension<UIColors>()!;

    return GetBuilder<LidarGroupController>(
        tag: tag,
        builder: (LidarGroupController controller) {

          LidarGroupModel? model = controller.getModel() as LidarGroupModel?;
          // print('model?.connection_status?.state: ${model?.connection_status?.state}');
          // print('model?.connection_status?.name: ${model?.connection_status?.name}');

          if(model == null) {
            print("model Null");
          }
          //
          // print( "Lidar : " + model!.stateStack.toString() );
          //
          //
          // print("Lidar : ControlActive : " + model.IsStateSuccess(eProcessingState.ControlActive).toString());
          // print("Lidar : NetworkConnected : " + model.IsStateSuccess(eProcessingState.NetworkConnected).toString());
          // print("Lidar : SensorConnected : " + model.IsStateSuccess(eProcessingState.SensorConnected).toString());
          // print("Lidar : SensorHealthy : " + model.IsStateSuccess(eProcessingState.SensorHealthy).toString());
          // print("Lidar : Acquiring : " + model.IsStateSuccess(eProcessingState.Acquiring).toString());
          // print("Lidar : Snap : " + model.IsStateSuccess(eProcessingState.Snap).toString());

          // print("rePaint!! : ${model?.row_image.toString()}");


          return Stack(
            children: [
              Positioned.fill(
                child: FractionallySizedBox(
                    widthFactor: 1, // 100% 폭
                    heightFactor: 1, // 100% 높이
                    child: Card(
                      color: Theme.of(context).colorScheme.surface,
                      child: ImageCanvasConsumeWidget(controller,tag),
                    )
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                child:Container(
                  height: 30,
                  // decoration: BoxDecoration(
                  //   color: (model!.IsStateSuccess(eProcessingState.SensorConnected)
                  //       ? uiColors.success
                  //       : uiColors.closed)?.withOpacity(0.8),
                  //   borderRadius: BorderRadius.circular(buttonBorderRadius),
                  // ),
                  padding: EdgeInsets.all(1.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          taggingMetaProperty.display_name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      if (!model!.IsStateSuccess(eProcessingState.SensorHealthy))
                        Image.asset(
                          'assets/img/sensor_out.png',
                          width: 20,
                          height: 20,
                        ),
                    ],
                  ),
                ),
                //
                // ElevatedButton(
                //     onPressed: () => {},
                //     style: ElevatedButton.styleFrom(
                //         backgroundColor: uiColors.success,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(buttonBorderRadius)
                //         )
                //     ),
                //     child: Text(_tag, style: Theme.of(context).textTheme.titleLarge)
                // )
              ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Text(
              //     'widget.viewModel.device.viewStatus' + '  ',// == LoggingStatus.ERROR ? 'Error !' : '',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),

              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  //widget.viewModel.device.loggingStatus == LoggingStatus.ERROR ? 'Error !' : '',
                  model.GetAcquiringStr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              // 이부분에 controller 의 특정 상태에 따라서 애니메이션 아이콘 (사용자기 만든)을 보여주고 싶은데 방법은?

              Align(
                alignment: Alignment(-1.05, -0.9),  // 더 아래로 배치
                child: IconButton(
                  onPressed: () => {
                    model.IsAcquiring() ? controller.StopSensorAcquisition() : controller.StartSensorAcquisition(),
                  },
                  iconSize: 48.0,  // 버튼의 크기를 키움
                  icon: Icon(
                    model.IsAcquiring() ? Icons.stop : Icons.play_arrow,
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}
