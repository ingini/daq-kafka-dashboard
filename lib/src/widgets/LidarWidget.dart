import 'package:daq_dashboard/src/Controllers/LidarController.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/LidarModel.dart';
import 'package:daq_dashboard/src/meta/MapTableHelper.dart';
import 'package:daq_dashboard/src/store/constant.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/ImageCanvasConsumeGateWay.dart';
import 'package:daq_dashboard/src/widgets/ImageCanvasConsumeWidget.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';


class LidarWidget extends TaggingStatefulWidget {

  LidarWidget( eTags taggingTag ) : super( taggingTag:taggingTag);

  @override
  TaggingWidgetState<LidarWidget> createState() =>  _LidarWidgetState(taggingMetaProperty);

}

class _LidarWidgetState extends TaggingWidgetState<LidarWidget> {

  _LidarWidgetState(metaProperty taggingMetaProperty) : super(taggingMetaProperty);

  @override
  Widget build(BuildContext context) {
    final UIColors uiColors = Theme.of(context).extension<UIColors>()!;

    return GetBuilder<LidarController>(
      tag: tag,
      builder: (LidarController controller) {

        LidarModel? model = controller.getModel() as LidarModel?;
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
        return GestureDetector(
          onTap:() async {
            // 여기에 클릭 시 실행할 controller의 함수 호출
            controller.OnTapWidget(); // 여기서 yourFunction을 controller의 실제 함수로 변경
          },
          child : Container (
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.yellow, width: 2),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            color: Colors.black,
            padding: EdgeInsets.all(5),
            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children : [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Container(
                            child: UIComponents.lidarRotateIcon(
                                LidarIconMapTableHelper.getLidarType( model!.tag )! ,
                                LidarIconMapTableHelper.rotateAngle( model!.tag )!),
                          ),
                          Container(
                            child: UIComponents.sensorConnectionStateIcon( model!.connection_state ),
                          ),
                        ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: UIComponents.sensorHealthIcon( model!.health_state),
                        ),
                        Container(
                          child: UIComponents.sensorAcquiringIcon( model!.acquisition_state ),
                        ),
                      ],
                    ),
                  ],
              ),
          //
          //
          //
          //   GridView.count(
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 10,
          //     crossAxisSpacing: 10,
          //     shrinkWrap: true,
          //     children: [
          //       // Icon(
          //       //   Icons.local_pizza,
          //       //   size: 38,
          //       //   color: Colors.grey,
          //       // ),
          //       Container(
          //         child: UIComponents.lidarRotateIcon(
          //             LidarIconMapTableHelper.getLidarType( model!.tag )! ,
          //             LidarIconMapTableHelper.rotateAngle( model!.tag )!),
          //       ),
          //       Container(
          //         child: UIComponents.sensorConnectionStateIcon( model!.connection_state ),
          //       ),
          //       Container(
          //         child: UIComponents.sensorHealthIcon( model!.health_state),
          //       ),
          //       Container(
          //         child: UIComponents.sensorAcquiringIcon( model!.acquisition_state ),
          //       ),
          //     ],
          //
          //   ),


          ),
        );
        },);
  }
}


