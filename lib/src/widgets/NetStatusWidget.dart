import 'package:daq_dashboard/src/Controllers/CanController.dart';
import 'package:daq_dashboard/src/Controllers/LidarController.dart';
import 'package:daq_dashboard/src/Controllers/NetStatusController.dart';
import 'package:daq_dashboard/src/dtos/MetaModelDto.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/Models/CanModel.dart';
import 'package:daq_dashboard/src/Models/LidarModel.dart';
import 'package:daq_dashboard/src/Models/NetStatusModel.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:daq_dashboard/src/store/constant.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/ImageCanvasConsumeGateWay.dart';
import 'package:daq_dashboard/src/widgets/ImageCanvasConsumeWidget.dart';
import 'package:daq_dashboard/src/widgets/StatusItem.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';


class NetStatusWidget extends TaggingStatefulWidget {

  NetStatusWidget( eTags taggingTag ) : super( taggingTag:taggingTag);

  @override
  TaggingWidgetState<NetStatusWidget> createState() =>  _NetStatusWidgetState(taggingMetaProperty);

}

class _NetStatusWidgetState extends TaggingWidgetState<NetStatusWidget> {

  _NetStatusWidgetState(metaProperty taggingMetaProperty) : super(taggingMetaProperty);


  MetaModelDtoContainer metaDtos = MetaModelDtoContainer();

  @override
  Widget build(BuildContext context) {
    final UIColors uiColors = Theme.of(context).extension<UIColors>()!;

    return GetBuilder<NetStatusController>(
        tag: tag,
        builder: (NetStatusController controller) {
          //
          NetStatusModel? model = controller.getModel() as NetStatusModel?;
          // // print('model?.connection_status?.state: ${model?.connection_status?.state}');
          // // print('model?.connection_status?.name: ${model?.connection_status?.name}');
          //
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

          metaDtos.clear();

          metaDtos.Append(eTags.trace_wan, MetaModelDto.Create(eTags.trace_wan,model!));
          metaDtos.Append(eTags.trace_lte, MetaModelDto.Create(eTags.trace_lte,model!));
          metaDtos.Append(eTags.dev_cpu  , MetaModelDto.Create(eTags.dev_cpu,model!));

          //TeleChips
          // metaDtos.Append(eTags.dev_vpu_a, MetaModelDto.Create(eTags.dev_vpu_a,model!));
          // metaDtos.Append(eTags.dev_vpu_b, MetaModelDto.Create(eTags.dev_vpu_b,model!));
          // metaDtos.Append(eTags.dev_vpu_c, MetaModelDto.Create(eTags.dev_vpu_c,model!));


          // print("=-=-==-=-=-=-=-=-=-=-=-=-  : ${metaDtos.toString()}    ===========");




          return Container(

            child: Column(
              children: [
                SizedBox(height : 10.h),
                Expanded(
                    child:
                    StatusItem(
                        icon: TablerIcons.cloud_network,
                        iconFail: TablerIcons.cloud_off,
                        label: metaDtos.getDisplayName(eTags.trace_wan),
                        connection_status: metaDtos.getDevicePingStatus(eTags.trace_wan),
                        health_status: null,
                   )
                ),
                Expanded(
                    child:
                    StatusItem(
                      icon: TablerIcons.router,
                      iconFail: TablerIcons.router_off,
                      label: metaDtos.getDisplayName(eTags.trace_lte),
                      connection_status: metaDtos.getDevicePingStatus(eTags.trace_lte),
                      health_status: null,
                    )
                ),
                Expanded(
                    child:  StatusItem(
                      icon: TablerIcons.cpu_2,
                      iconFail: TablerIcons.cpu_off,
                      label: metaDtos.getDisplayName(eTags.dev_cpu),
                      connection_status: metaDtos.getDevicePingStatus(eTags.dev_cpu),
                      health_status: metaDtos.getDeviceHealthStatus(eTags.dev_cpu),
                    )
                ),
                // Expanded(
                //     child:  StatusItem(
                //       icon: TablerIcons.cpu,
                //       iconFail: TablerIcons.cpu_off,
                //       label: metaDtos.getDisplayName(eTags.dev_vpu_a),
                //       connection_status: metaDtos.getDeviceConnectionState(eTags.dev_vpu_a),
                //       health_status: metaDtos.getDeviceHealthStatus(eTags.dev_vpu_a),
                //     )
                // ),
                // Expanded(
                //     child:  StatusItem(
                //       icon: TablerIcons.cpu,
                //       iconFail: TablerIcons.cpu_off,
                //       label: metaDtos.getDisplayName(eTags.dev_vpu_b),
                //       connection_status: metaDtos.getDeviceConnectionState(eTags.dev_vpu_b),
                //       health_status: metaDtos.getDeviceHealthStatus(eTags.dev_vpu_b),
                //     )
                // ),
                // Expanded(
                //     child:  StatusItem(
                //       icon: TablerIcons.cpu,
                //       iconFail: TablerIcons.cpu_off,
                //       label: metaDtos.getDisplayName(eTags.dev_vpu_c),
                //       connection_status: metaDtos.getDeviceConnectionState(eTags.dev_vpu_c),
                //       health_status: metaDtos.getDeviceHealthStatus(eTags.dev_vpu_c),
                //     )
                // ),
                SizedBox(height : 10.h),

              ],
            ),

          );

        }
    );
  }
}