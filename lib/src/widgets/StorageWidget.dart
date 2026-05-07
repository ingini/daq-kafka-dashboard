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

class StorageWidget extends TaggingStatefulWidget {

  StorageWidget( eTags taggingTag ) : super( taggingTag:taggingTag);

  @override
  TaggingWidgetState<StorageWidget> createState() => _StorageWidgetState(taggingMetaProperty);
}

class _StorageWidgetState extends TaggingWidgetState<StorageWidget> {

  _StorageWidgetState(metaProperty taggingMetaProperty) : super(taggingMetaProperty);


  @override
  Widget build(BuildContext context) {
    // final UIColors uiColors = Theme.of(context).extension<UIColors>()!;

    return GetBuilder<StorageController>(
        tag: tag,
        builder: (StorageController controller) {
          //
          StorageModel? model = controller.getModel() as StorageModel? ;
          // print('model?.connection_status?.state: ${model?.connection_status?.state}');
          // print('model?.connection_status?.name: ${model?.connection_status?.name}');

          if(model == null) {
            print("model Null");
          }

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
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1, // 위성 정보 부분
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 자식들 사이의 공간 최대로 확장
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Expanded(
                              //   flex: 1,
                              //   child: Row(
                              //     children: [
                              //       Text(
                              //         "Storage",
                              //         style: TextStyle(fontSize: 14, color: Colors.green), // 글씨 크기와 색상 설정
                              //       ),
                              //       Image.asset('assets/img/icon-storage-connected.png', width: 70, height: 70),
                              //       Text(
                              //         model!.getUIStorageConnected(),
                              //         style: TextStyle(fontSize: 14, color: Colors.green), // 글씨 크기와 색상 설정
                              //       ),
                              //     ],
                              //   ), // test1 텍스트
                              // ),


                              Expanded(
                                flex: 1,
                                child: Container(
                                  // color: Colors.orange.withOpacity(0.3),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 15.h),
                                      UIComponents.storageProgressBar(model),

                                      // Container(
                                      //   height: 30, // 높이 조정
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.grey[900],
                                      //     borderRadius: BorderRadius.circular(10),
                                      //     border: Border.all(
                                      //       color: Colors.white!,
                                      //       width: 2,
                                      //     ),
                                      //   ),
                                      //   child: ClipRRect(
                                      //     borderRadius: BorderRadius.circular(10 - 4),
                                      //     child: LinearProgressIndicator(
                                      //       value: model?.getUIRemainStock(), // 용량 비율
                                      //       backgroundColor: Color(0xFF183C28),
                                      //       valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEEC643)),
                                      //     ),
                                      //   ),
                                      // ),
                                    //
                                    // SizedBox(height: 10), // 간격 추가
                                    //
                                    // Container(
                                    //   child: Row(
                                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Container(
                                    //         child: UIComponents.text("text", Colors.white54),
                                    //       ),
                                    //       Container(
                                    //         child: UIComponents.text("text", Colors.white54),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                                                ),
                                ), // test2 텍스트
                            ),

                            Expanded(
                                flex: 2,
                                child: Container(
                                  // color: Colors.blue.withOpacity(0.3),
                                  child: UIComponents.storageStatus(model),
                                )
                            ),


                              // Expanded(
                              //   flex: 1,
                              //     child: Container()
                              // ),



                              // Expanded(
                              //   flex: 1,
                              //   child: Text(
                              //     model!.getUIStorageStock(), // 사용된 용량 / 전체 용량
                              //     style: TextStyle(fontSize: 14, color: Colors.white),
                              //   ), // test3 텍스트
                              // ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // if (!model.IsStateSuccess(eProcessingState.SensorConnected))
              //   Positioned(
              //     left: 0,
              //     right: 0,
              //     child: Container(
              //       height: 25,
              //       decoration: BoxDecoration(
              //         color: uiColors.closed!.withOpacity(0.8), // 녹색 바 설정
              //         borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(4),
              //           topRight: Radius.circular(4),
              //         ), // 모서리 둥글게 처리
              //       ),
              //       padding: EdgeInsets.symmetric(horizontal: 8.0),
              //       child: Row(
              //         mainAxisSize: MainAxisSize.max,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Expanded(
              //             child: Text(
              //               "Storage Disconneted",
              //               style: TextStyle(fontSize: 14, color: Colors.white),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              //
              // Positioned(
              //   right: 5,
              //   bottom: 3,
              //   child: Text(
              //     model.GetAcquiringStr(),
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              //   ),
              // ),

              // Positioned(
              //   right: -10,
              //   top: -13,
              //   child: IconButton(
              //     onPressed: () => {
              //       model.IsAcquiring() ? controller.StopSensorAcquisition() : controller.StartSensorAcquisition(),
              //     },
              //     iconSize: 48.0,  // 버튼의 크기를 키움
              //     icon: Icon(
              //       model.IsAcquiring() ? Icons.stop : Icons.play_arrow,
              //     ),
              //   ),
              // ),
            ],
          );




          //
          //
          // return Container(
          //   decoration: BoxDecoration(
          //     color: Colors.blueGrey[900], // 배경색 설정
          //     border: Border.all(color: Colors.green, width: 2), // 녹색 테두리 추가
          //     borderRadius: BorderRadius.circular(4), // 모서리를 둥글게 처리
          //   ),
          //   child: Column(
          //     children: [
          //       if (!model.IsStateSuccess(eProcessingState.SensorConnected))
          //       Container(
          //         height: 25,
          //         decoration: BoxDecoration(
          //           color: uiColors.closed!.withOpacity(0.8), // 녹색 바 설정
          //           borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(4),
          //             topRight: Radius.circular(4),
          //           ), // 모서리 둥글게 처리
          //         ),
          //         padding: EdgeInsets.symmetric(horizontal: 8.0),
          //         child: Row(
          //           mainAxisSize: MainAxisSize.max,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Expanded(
          //               child: Text(
          //                 "Storage",
          //                 style: TextStyle(fontSize: 14, color: Colors.white),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Expanded(
          //           flex: 1, // 위성 정보 부분
          //           child: Container(
          //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,  // 자식들 사이의 공간 최대로 확장
          //                 crossAxisAlignment: CrossAxisAlignment.stretch,
          //
          //                 children: [
          //                   Expanded(
          //                     flex: 1,
          //                     child: Row(
          //                       children: [
          //                         Text(
          //                           "Storage",
          //                           style: TextStyle(fontSize: 14, color: Colors.green), // 글씨 크기와 색상 설정
          //                         ),
          //                         Image.asset('assets/img/icon-storage-connected.png', width: 70, height: 70),
          //                         Text(
          //                           model!.getUIStorageConnected(),
          //                           style: TextStyle(fontSize: 14, color: Colors.green), // 글씨 크기와 색상 설정
          //                         ),
          //                       ],
          //                     ),  // test1 텍스트
          //                   ),
          //                   Expanded(
          //                     flex: 2,
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         SizedBox(height: 12),
          //                         Container(
          //                           height: 30, // 높이 조정
          //                           child: LinearProgressIndicator(
          //                             value: model?.getUIRemainStock(), // 용량 비율
          //                             backgroundColor: Colors.grey[300],
          //                             valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          //                           ),
          //                         ),
          //                         // SizedBox(height: 10), // 간격 추가
          //                       ],
          //                     ),  // test2 텍스트
          //                   ),
          //                   Expanded(
          //                     flex: 1,
          //                     child: Text(
          //                       model!.getUIStorageStock(), // 사용된 용량 / 전체 용량
          //                       style: TextStyle(fontSize: 14, color: Colors.white),
          //                     ),  // test3 텍스트
          //                   ),
          //                 ],
          //               )
          //
          //           )
          //       )
          //     ],
          //   ),
          // );


          //
          // return Expanded(
          //   child: Container(
          //     color: Colors.blueGrey[900],  // 배경색 설정
          //     padding: const EdgeInsets.all(1),
          //     decoration: BoxDecoration(
          //         color: Colors.transparent,  // 내부 색상 투명
          //         border: Border.all(color: Colors.green, width: 2),  // 녹색 테두리
          //         borderRadius: BorderRadius.circular(4)  // 모서리를 둥글게
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.stretch,  // 자식들을 수평으로 확장하여 왼쪽 정렬
          //       children: [
          //         Expanded(
          //           flex: 1,
          //           child: Padding(
          //             padding: const EdgeInsets.only(left: 16),  // 왼쪽 패딩 추가
          //             child: Row(
          //               children: [
          //                 Text(
          //                   "ㅐㅏㅐㅏ",
          //                   style: TextStyle(fontSize: 12, color: Colors.green),  // 글씨 크기와 색상 설정
          //                 ),
          //                 Image.asset('assets/img/icon-storage-connected.png', width: 70, height: 70),
          //               ],
          //             ),
          //           ),
          //         ),
          //         Expanded(
          //           flex: 2,
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   height: 22,  // 높이 조정
          //                   child: LinearProgressIndicator(
          //                     value: 0.2,  // 용량 비율
          //                     backgroundColor: Colors.grey[300],
          //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          //                   ),
          //                 ),
          //                 SizedBox(height: 10),  // 간격 추가
          //                 Text(
          //                   'Total 90 GB , free 34 GB  34% Used',  // 사용된 용량 / 전체 용량
          //                   style: TextStyle(fontSize: 12, color: Colors.white),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // );

          //
          // return Expanded(
          //   child: Container(
          //     color: Colors.blueGrey[900],  // 배경색 설정
          //     child: Padding(
          //       padding: const EdgeInsets.all(1),
          //       child: SizedBox.expand(
          //         child: Container(
          //           decoration: BoxDecoration(
          //               color: Colors.transparent,  // 내부 색상 투명
          //               border: Border.all(color: Colors.green, width: 2),  // 녹색 테두리
          //               borderRadius: BorderRadius.circular(4)  // 모서리를 둥글게
          //           ),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.stretch,  // 자식들을 수평으로 확장하여 왼쪽 정렬
          //             children: [
          //               Expanded(
          //                 flex: 1,
          //                 child: Padding(
          //                   padding: const EdgeInsets.only(left: 16),  // 왼쪽 패딩 추가
          //                   child: Row(
          //                     children: [
          //                       Text(
          //                         model?.sensorName ?? "",
          //                         style: TextStyle(fontSize: 12, color: Colors.green),  // 글씨 크기와 색상 설정
          //                       ),
          //                       Image.asset('assets/img/icon-storage-connected.png', width: 70, height: 70),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //               Expanded(
          //                 flex: 2,
          //                 child: Padding(
          //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Container(
          //                         height: 22,  // 여기에서 높이 조정
          //                         child: LinearProgressIndicator(
          //                           value: 0.2,  // 용량 비율
          //                           backgroundColor: Colors.grey[300],
          //                           valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          //                         ),
          //                       ),
          //                       SizedBox(height: 10),  // 간격 추가
          //                       Text(
          //                         'Total 90 GB , free 34 GB  34% Used',  // 사용된 용량 / 전체 용량
          //                         style: TextStyle(fontSize: 12, color: Colors.white),
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ],
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