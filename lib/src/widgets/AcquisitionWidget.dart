import 'package:daq_dashboard/src/Controllers/AcquisitionController.dart';
import 'package:daq_dashboard/src/Controllers/StorageController.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/StorageModel.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';

class AcquisitionWidget extends TaggingStatefulWidget {

  AcquisitionWidget( eTags taggingTag ) : super(taggingTag: taggingTag);

  @override
  TaggingWidgetState<AcquisitionWidget> createState() => _AcquisitionWidgetState(taggingMetaProperty);
}

class _AcquisitionWidgetState extends TaggingWidgetState<AcquisitionWidget> {

  _AcquisitionWidgetState(metaProperty taggingMetaProperty) : super(taggingMetaProperty);


  @override
  Widget build(BuildContext context) {
    // final UIColors uiColors = Theme.of(context).extension<UIColors>()!;

    return GetBuilder<AcquisitionController>(
        tag: tag,
        builder: (AcquisitionController controller) {
          //
          // StorageModel? model = controller.getModel() as StorageModel? ;
          // // print('model?.connection_status?.state: ${model?.connection_status?.state}');
          // // print('model?.connection_status?.name: ${model?.connection_status?.name}');
          //
          // if(model == null) {
          //   print("model Null");
          // }

          // print( "Storage : " + model!.stateStack.toString() );
          //
          // print("Storage : ControlActive : " + model.IsStateSuccess(eProcessingState.ControlActive).toString());
          // print("Storage : NetworkConnected : " + model.IsStateSuccess(eProcessingState.NetworkConnected).toString());
          // print("Storage : SensorConnected : " + model.IsStateSuccess(eProcessingState.SensorConnected).toString());
          // print("Storage : SensorHealthy : " + model.IsStateSuccess(eProcessingState.SensorHealthy).toString());
          // print("Storage : Acquiring : " + model.IsStateSuccess(eProcessingState.Acquiring).toString());
          // print("Storage : Snap : " + model.IsStateSuccess(eProcessingState.Snap).toString());


          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.blueGrey[900], // 배경색 설정
                  //   border: Border.all(color: Colors.green, width: 2), // 녹색 테두리 추가
                  //   borderRadius: BorderRadius.circular(4), // 모서리를 둥글게 처리
                  // ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1, // 위성 정보 부분
                        child: GestureDetector(
                          onTap:() async {
                            // 여기에 클릭 시 실행할 controller의 함수 호출
                            controller.OnTapStartAllAcquiring(); // 여기서 yourFunction을 controller의 실제 함수로 변경
                          },
                          child: Container(
                              child: UIComponents.acquisitionStartBtn()
                          ),
                        ),
                      ),
                      SizedBox(width: 17.w), // 간격 추가
                      Expanded(
                        flex: 1, // 위성 정보 부분
                        child: GestureDetector(
                          onTap:() async {
                            // 여기에 클릭 시 실행할 controller의 함수 호출
                            controller.OnTapStopAllAcquiring(); // 여기서 yourFunction을 controller의 실제 함수로 변경
                          },
                          child: Container(
                              child: UIComponents.acquisitionStopBtn()
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          );

        }
    );
  }
}