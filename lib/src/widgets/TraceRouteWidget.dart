import 'package:daq_dashboard/src/Controllers/CameraController.dart';
import 'package:daq_dashboard/src/Controllers/TraceRouteController.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/CameraModel.dart';
import 'package:daq_dashboard/src/Models/TraceRouteModel.dart';
import 'package:daq_dashboard/src/store/constant.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//
// class TraceRouteWidget extends TaggingStatefulWidget {
//
//   TraceRouteWidget( eTags taggingTag ) : super( taggingTag);
//
//   @override
//   TaggingWidgetState<TraceRouteWidget> createState() => _TraceRouteWidgetState(taggingMetaProperty);
// }
//
// class _TraceRouteWidgetState extends TaggingWidgetState<TraceRouteWidget> {
//
//   _TraceRouteWidgetState(metaProperty taggingMetaProperty) : super(taggingMetaProperty);
//
//
//   @override
//   Widget build(BuildContext context) {
//     final UIColors uiColors = Theme.of(context).extension<UIColors>()!;
//
//     return GetBuilder<TraceRouteController>(
//         tag: tag,
//         builder: (TraceRouteController controller) {
//           //
//           TraceRouteModel? model = controller.getModel() as TraceRouteModel;
//           // print('model?.connection_status?.state: ${model?.connection_status?.state}');
//           // print('model?.connection_status?.name: ${model?.connection_status?.name}');
//
//           // if(model == null) {
//           //   print("model Null");
//           // }
//
//           // print("model 1 1 1 11 1 1 1 1 1 1 1 1 ");
//
//
//           return Container(
//             color: Colors.blueGrey[900],  // 배경색 설정
//             child: Padding(
//               padding: const EdgeInsets.all(1),
//               child: Row(
//                 children: [
//                   Flexible(
//                     flex: 1,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                           color: Colors.transparent, // 내부 색상 투명
//                           border: Border.all(color: Colors.green, width: 2), // 녹색 테두리
//                           borderRadius: BorderRadius.circular(4) // 모서리를 둥글게
//                       ),
//                       // width: 200.0,  // 컨테이너의 폭을 최대로 확장
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,  // 자식들 사이의 공간 최대로 확장
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,  // 자식들 사이의 공간 최대로 확장
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Flexible(
//                             child: Text(
//                                 taggingMetaProperty.display_name,  // 상태 제목
//                                 style: TextStyle(fontSize: 12, color: Colors.green)  // 녹색 글씨
//                             ),
//                           ),
//                           Flexible(
//                             flex: 2,
//                             child: Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     model!.getIp() ,  // 상태 제목
//                                     style: TextStyle(fontSize: 15, color: Colors.white)  // 녹색 글씨
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             child: Column(
//                               children: [
//                                 Icon( model!.isSuccessFull() == false ? Icons.block : Icons.rss_feed, color: model!.isSuccessFull() == false ? Colors.red : Colors.green ),
//                                 Text(
//                                     model!.isSuccessFull() == false ? "" : model!.getDurationTimeMsStr() ,  //
//                                     style: TextStyle(fontSize: 10, color: Colors.green)  // 녹색 글씨
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Flexible(
//                           //   child: Align(
//                           //     // alignment: Alignment.center,
//                           //     child: Icon(Icons.rss_feed, color: Colors.green ),
//                           //     // child: Icon(Icons.block, color: Colors.red ),
//                           //   ),
//                           // ),
//                           // Row(
//                           //   mainAxisSize: MainAxisSize.min,
//                           //   children: [
//                           //     Icon(Icons.rss_feed, color: Colors.green ),  // 아이콘
//                           //     SizedBox(width: 5),  // 아이콘과 텍스트 사이 간격
//                           //
//                           //   ],
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//     );
//   }
// }