import 'package:daq_dashboard/src/Controllers/CameraController.dart';
import 'package:daq_dashboard/src/Controllers/StorageController.dart';
import 'package:daq_dashboard/src/Controllers/TraceRouteController.dart';
import 'package:daq_dashboard/src/Models/CameraModel.dart';
import 'package:daq_dashboard/src/Models/StorageModel.dart';
import 'package:daq_dashboard/src/Models/TraceRouteModel.dart';
import 'package:daq_dashboard/src/store/constant.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'ImageCanvasConsumeGateWay.dart';
import 'ImageCanvasConsumeWidget.dart';

class SWidget extends StatefulWidget {

  final String _tag;

  const SWidget( String tag)
      : _tag = tag;

  @override
  _SWidgetState createState() => _SWidgetState(_tag);
}

class _SWidgetState extends State<SWidget> {

  final String _tag;

  _SWidgetState(this._tag);


  @override
  Widget build(BuildContext context) {
    final UIColors uiColors = Theme.of(context).extension<UIColors>()!;

    return GetBuilder<StorageController>(
        tag: _tag,
        builder: (StorageController controller) {
          //
          StorageModel? model = controller.getModel() as StorageModel;
          // print('model?.connection_status?.state: ${model?.connection_status?.state}');
          // print('model?.connection_status?.name: ${model?.connection_status?.name}');

          // if(model == null) {
          //   print("model Null");
          // }


          return Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[900], // 배경색 설정
                border: Border.all(color: Colors.green, width: 2), // 녹색 테두리 추가
                borderRadius: BorderRadius.circular(4), // 모서리를 둥글게 처리
              ),
            child: Column(
              children: [
                Expanded(
                  flex: 1, // 위성 정보 부분
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,  // 자식들 사이의 공간 최대로 확장
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(
                                  "ㅐㅏㅐㅏ",
                                  style: TextStyle(fontSize: 12, color: Colors.green), // 글씨 크기와 색상 설정
                                ),
                                Image.asset('assets/img/icon-storage-connected.png', width: 70, height: 70),
                              ],
                            ),  // test1 텍스트
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Container(
                                  height: 30, // 높이 조정
                                  child: LinearProgressIndicator(
                                    value: 0.2, // 용량 비율
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                  ),
                                ),
                                // SizedBox(height: 10), // 간격 추가
                              ],
                            ),  // test2 텍스트
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Total 90 GB, free 34 GB, 34% Used', // 사용된 용량 / 전체 용량
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),  // test3 텍스트
                          ),
                        ],
                      )
                    )
                )
              ],
            ),
          );

          //
          // return Expanded(
          //   child: Container(
          //     color: Colors.blueGrey[900],
          //     child: Align(
          //       alignment: Alignment.center,
          //       child: Padding(
          //         padding: const EdgeInsets.all(1),
          //         child: SizedBox.expand(  // SizedBox.expand 사용하여 최대 공간 활용
          //           child: Container(
          //             decoration: BoxDecoration(
          //                 color: Colors.transparent,
          //                 border: Border.all(color: Colors.green, width: 2),
          //                 borderRadius: BorderRadius.circular(4)
          //             ),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               mainAxisSize: MainAxisSize.max,
          //               children: [
          //                 Expanded(
          //                   flex :1,
          //                   child: Center(child: Text("test1")),  // test1 텍스트
          //                 ),
          //                 Expanded(
          //                   flex :2,
          //                   child: Center(child: Text("test2")),  // test2 텍스트
          //                 ),
          //                 Expanded(
          //                   flex :2,
          //                   child: Center(child: Text("test3")),  // test3 텍스트
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // );

        }
    );
  }
}