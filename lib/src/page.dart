// import 'package:daq_dashboard/src/Controllers/NetController.dart';
// import 'package:daq_dashboard/src/meta/Defines.dart';
// import 'package:daq_dashboard/src/meta/Modes.dart';
// import 'package:daq_dashboard/src/widgets/CameraWidget.dart';
// import 'package:daq_dashboard/src/widgets/ConnectionStatueWidget.dart';
// import 'package:daq_dashboard/src/widgets/DeviceWidget.dart';
// import 'package:daq_dashboard/src/widgets/GnssWidget.dart';
// import 'package:daq_dashboard/src/widgets/LidarGroupWidget.dart';
// import 'package:daq_dashboard/src/widgets/TraceRouteWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// // project imports
// import 'package:daq_dashboard/src/store/constant.dart';
// import 'package:daq_dashboard/src/themes/theme.dart';
//
// import 'package:flutter/foundation.dart';
//
// import 'widgets/StorageWidget.dart';
//
// class UIPage extends StatefulWidget {
//   const UIPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<UIPage> createState() => _UIPage();
// }
//
// class _UIPage extends State<UIPage> {
//   // LoggingStatus allLoggingStatus = LoggingStatus.WAITING;
//
//
//
//   void initState()  {
//     super.initState();
//     initializeState();
//     print("page Init");
//   }
//
//   void initializeState() async {
//     // var configUtils = ConfigUtil.instance;
//     // ConnectInfoDTO? connectInfo = await ConnectInfoDtoFactory.getConnectInfo( configUtils ) ;
//     // Get.put(NetController(connectInfo));
//     //
//     // // String tag1 = "cam1";
//     //
//     // Get.put( ImageController( Get.find<NetController>().rpcClientRap , 1000 , Defines.tag1 , true ) , tag: Defines.tag1 );
//   }
//
//   //
//   // void updateAllLoggingStatus(LoggingStatus newStatus) {
//   //
//   //   // Provider.of<CPUDumpCamViewModel>(context, listen: false).setLoggingStatus(newStatus);
//   //   // Provider.of<CPUDumpLidarViewModel>(context, listen: false).setLoggingStatus(newStatus);
//   //   // Provider.of<CPUDumpGNSSViewModel>(context, listen: false).setLoggingStatus(newStatus);
//   // }
//
//   void toggleLoggingStatus() {
//     setState(() {
//       // switch (allLoggingStatus) {
//       //   case LoggingStatus.LOGGING:
//       //     allLoggingStatus = LoggingStatus.WAITING;
//       //     updateAllLoggingStatus(LoggingStatus.WAITING);
//       //     break;
//       //   case LoggingStatus.WAITING:
//       //     allLoggingStatus = LoggingStatus.LOGGING;
//       //     updateAllLoggingStatus(LoggingStatus.LOGGING);
//       //     break;
//       //   case LoggingStatus.ERROR:
//       //     // Do nothing for now
//       //     break;
//       // }
//     });
//   }
//
//
//   void _setupGrpcClient(BuildContext context) {
//     // final grpcClient = Provider.of<DaqGatewayProvider>(context, listen: false).getClient();
//
//     // final rpcClientRapper = Provider.of<NetClientProviderManager>(context, listen: false).rpcClientRap;
//
//     // print("wadawdawd");
//
//     //
//     // Provider.of<DeviceProvider>(context, listen: false).setRpcClient(rpcClientRapper);
//     // Provider.of<ImageRpcProvider>(context, listen: false).setRpcClient(rpcClientRapper);
//
//     // Provider.of<LiDAR1ViewModel>(context ).setRpcClient(rpcClientRapper) ;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;
//     final uiColors = Theme.of(context).extension<UIColors>()!;
//
//
//     ////////////////////////////////////////////////////////////////////
//     // ReFactory
//
//
//     final NetController netController = Get.find<NetController>();
//
//
//     _setupGrpcClient(context);
//
//     return Scaffold(
//         backgroundColor: colors.background,
//         appBar: AppBar(
//           backgroundColor: colors.background,
//           title: Row(
//             children: [
//               Text(widget.title,
//                   style: Theme.of(context).textTheme.headlineSmall),
//               SizedBox(width: 30),
//               ConnectionStatusWidget(),
//               ElevatedButton(
//                 onPressed: () {
//                   print("BtnClicked");
//                   netController.connectTest();
//                 },
//                 child: Text('Conn Test'),
//               ),
//               SizedBox(width: 8), // 버튼 사이의 공간
//               ElevatedButton(
//                 onPressed: () {
//                   print("Btn 2 Clicked");
//                   netController.connectRelease();
//                 },
//                 child: Text('Conn Release'),
//               ),
//               SizedBox(width: 8), // 버튼 사이의 공간
//               ElevatedButton(
//                 onPressed: () {
//                   print("Btn 3 Clicked");
//                   netController.disconnect();
//                 },
//                 child: Text('Disconnect'),
//               )
//             ],
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: padding),
//               child: Container(
//                 color: colors.background,
//                 child: Row(
//                   children: [
//
//                     Align(
//                       alignment: Alignment.center,
//                       child: IconButton(
//                           onPressed: () => {
//
//                           },
//                           icon: Icon(
//                             Icons.play_arrow,
//                           ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: IconButton(
//                         onPressed: () => {
//
//                         },
//                         icon: Icon(
//                           Icons.stop,
//                         ),
//                       ),
//                     ),
//
//                     // ElevatedButton(
//                     //     onPressed: () => toggleLoggingStatus(),
//                     //     style: ElevatedButton.styleFrom(
//                     //         backgroundColor: allLoggingStatus == LoggingStatus.LOGGING
//                     //             ? uiColors.success
//                     //             : colors.primary,
//                     //         shape: RoundedRectangleBorder(
//                     //             borderRadius:
//                     //                 BorderRadius.circular(buttonBorderRadius))),
//                     //     child: Text(
//                     //         allLoggingStatus == LoggingStatus.LOGGING
//                     //             ? '로깅 종료'
//                     //             : '로깅 시작',
//                     //         style: Theme.of(context).textTheme.titleLarge)
//                     // ),
//                     // ElevatedButton(
//                     //     onPressed: () => toggleLoggingStatus(),
//                     //     style: ElevatedButton.styleFrom(
//                     //         backgroundColor: allLoggingStatus == LoggingStatus.LOGGING
//                     //             ? uiColors.success
//                     //             : colors.primary,
//                     //         shape: RoundedRectangleBorder(
//                     //             borderRadius:
//                     //             BorderRadius.circular(buttonBorderRadius))),
//                     //     child: Text(
//                     //         allLoggingStatus == LoggingStatus.LOGGING
//                     //             ? '로깅 종료'
//                     //             : '로깅 시작',
//                     //         style: Theme.of(context).textTheme.titleLarge)
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body:
//           Column(children: [
//           containerSpace,
//           Flexible(
//             flex: 4,
//             child: Container(
//               color: RunMode.IsDebug() ? Colors.purple : null,
//               child: Row(
//                 children: [
//                   containerSpace,
//                   Flexible(
//                       flex: 2,
//                       child: Center(
//                           child:
//                           Container(
//                             color: RunMode.IsDebug() ? Colors.red : null,
//                             child: Column(
//                             children: [
//                               Flexible(
//                                 flex: 1,
//                                 child: DeviceWidget(eTags.dev_cpu),
//                               ),
//                               containerSpace,
//                               Flexible(
//                                   flex: 15,
//                                   child: Container(
//                                     color: RunMode.IsDebug() ? Colors.green : null,
//                                     child: LidarGroupWidget(eTags.lidar),
//                                   )
//                               ),
//                             ],
//                                                   ),
//                           ),
//                       )),
//                   containerSpace,
//                   // camera -------------------------------------------------------------------
//                   Flexible(
//                     flex: 3,
//                     child: Container(
//                       color: RunMode.IsDebug() ? Colors.blue : null,
//                       child: Column(
//                         children: [
//                           Flexible(
//                             flex: 3,
//                             child:
//                             Container(
//                               color: RunMode.IsDebug() ? Colors.red : null,
//                               child: Column(
//                                 children: [
//                                   Flexible(
//                                       flex: 1,
//                                       child: DeviceWidget(eTags.dev_vpu_a)),
//                                   Flexible(
//                                     flex: 3,
//                                     child:  Row(
//                                       children: [
//                                         Flexible(
//                                             flex: 1,
//                                             child: CameraWidget(eTags.cam_a_1)),
//                                         containerSpaceCam,
//                                         Flexible(
//                                             flex: 1,
//                                             child: CameraWidget(eTags.cam_a_2)),
//                                         containerSpaceCam,
//
//                                         // const Flexible(flex: 1, child: UIDummy()),
//                                         // containerSpaceCam,
//                                         // const Flexible(flex: 1, child: UIDummy())
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//
//                           containerSpace,
//                           Flexible(
//                             flex: 3,
//                             child:
//                             Container(
//                               color: RunMode.IsDebug() ? Colors.green : null,
//                               child: Column(
//                                 children: [
//                                   Flexible(
//                                       flex: 1,
//                                       child: DeviceWidget(eTags.dev_vpu_b)),
//                                   Flexible(
//                                     flex: 3,
//                                     child:  Row(
//                                       children: [
//                                         Flexible(
//                                             flex: 1,
//                                             child: CameraWidget(eTags.cam_b_1)),
//                                         containerSpaceCam,
//                                         Flexible(
//                                             flex: 1,
//                                             child: CameraWidget(eTags.cam_b_2)),
//                                         containerSpaceCam,
//                                         Flexible(
//                                             flex: 1,
//                                             child: CameraWidget(eTags.cam_b_3)),
//                                         containerSpaceCam,
//                                         Flexible(
//                                             flex: 1,
//                                             child: CameraWidget(eTags.cam_b_4)),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//
//                           containerSpace,
//                           Flexible(
//                             flex: 3,
//                             child:
//                             Container(
//                               color: RunMode.IsDebugColor(Colors.red)  ,
//                               child: Column(
//                                 children: [
//                                   Flexible(
//                                       flex: 1,
//                                       child: DeviceWidget(eTags.dev_vpu_c)),
//                                   Flexible(
//                                     flex: 3,
//                                     child:  Row(
//                                       children: [
//                                         Flexible(
//                                             flex: 1,
//                                             child: CameraWidget(eTags.cam_c_1)),
//                                         containerSpaceCam,
//                                         Flexible(
//                                             flex: 1,
//                                             child: CameraWidget(eTags.cam_c_2)),
//                                         containerSpaceCam,
//                                         Flexible(
//                                             flex: 1,
//                                             child: CameraWidget(eTags.cam_c_3)),
//                                         containerSpaceCam,
//                                         Flexible(
//                                             flex: 1,
//                                             child: CameraWidget(eTags.cam_c_4)),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Flexible(
//                           //     flex: 1,
//                           //     child: Row(
//                           //       children: [
//                           //         // Flexible(
//                           //         //     child: UINetwork(viewModel: lteViewModel)),
//                           //         // containerSpace,
//                           //         // Flexible(
//                           //         //     child: UINetwork(viewModel: wanViewModel)),
//                           //         // containerSpace,
//                           //         // Flexible(
//                           //         //     child: UILoggingStorage(
//                           //         //         viewModel: loggingStorageViewModel))
//                           //       ],
//                           //     ))
//                         ],
//                       ),
//                     ),
//                   ),
//                   containerSpace,
//                   //loggingStorageViewModel.device.popupState != PopupState.NONE ? FlutterDialog('경고', '테스트') : '',
//                 ],
//               ),
//             ),
//           ),
//           containerSpace,
//           Flexible(
//             flex: 1,
//
//
//               child: Container(
//                 color: RunMode.IsDebug() ? Colors.green : null,
//                 child: Row(
//                   children: [
//                     // Flexible(
//                     //     flex: 1,
//                     //     child: Container(
//                     //     color: Colors.red,
//                     //     )
//                     // ),
//                     containerSpace,
//                     Flexible(
//                         flex: 1,
//                         child: Container(
//                           color: RunMode.IsDebug() ? Colors.blue : null,
//                           child: GnssWidget(eTags.gnss ),
//                         )
//                     ),
//                     // containerSpace,
//                     Flexible(
//                         flex: 1,
//                         child: Row(
//                           children: [
//                             Flexible(
//                               flex: 3,
//                               child: Container(
//                                 color: Colors.yellow,
//                                 child: StorageWidget(eTags.storage),
//                                 // child: SWidget(Defines.storage ),
//                               ),
//                             ),
//                             Flexible(
//                               flex: 2,
//                               child: Container(
//                                 color: RunMode.IsDebug() ? Colors.purple : null,
//                                 child: Column (
//                                   children: [
//                                     Flexible(
//                                       flex: 1,
//                                       child: Container( // lte ping
//                                         color: RunMode.IsDebug() ? Colors.red : null,
//                                         child: TraceRouteWidget(eTags.trace_lte),
//                                       ),
//                                     ),
//                                     Flexible(
//                                       flex: 1,
//                                       child: Container( // wan ping
//                                         color: RunMode.IsDebug() ? Colors.green : null,
//                                         child: TraceRouteWidget(eTags.trace_wan),
//                                       ),
//                                     ),
//                                   ]
//                                 ) ,
//                               ),
//                             ),
//                           ],
//                         )
//                     ),
//                     containerSpace,
//                 ],
//               ),
//           ),
//           ),
//
//           // if (loggingStorageViewModel.device.popupState != PopupState.NONE)
//           //   AlertDialog(
//           //     title: Text("알림"),
//           //     content: Text("외장디스크 공간부족!!"),
//           //     actions: [
//           //       TextButton(
//           //         onPressed: () {
//           //           setState(() {
//           //             loggingStorageViewModel.device.popupState = PopupState.NONE;
//           //           });
//           //         },
//           //         child: Text("닫기"),
//           //       ),
//           //     ],
//           //   ),
//         ]),
//     );
//   }
//
//
// }
