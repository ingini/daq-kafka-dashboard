
import 'package:daq_dashboard/src/Controllers/NetController.dart';
import 'package:daq_dashboard/src/meta/Modes.dart';
import 'package:daq_dashboard/src/network/networkConts.dart';
import 'package:daq_dashboard/src/store/constant.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:daq_dashboard/src/themes/theme.dart';

class ConnectionStatusWidget extends StatefulWidget {


  const ConnectionStatusWidget()
      : super();

  @override
  _ConnectionStatusWidgetState createState() => _ConnectionStatusWidgetState();
}

class _ConnectionStatusWidgetState extends State<ConnectionStatusWidget> {

  _ConnectionStatusWidgetState();

  @override
  Widget build(BuildContext context) {
    final UIColors uiColors = Theme.of(context).extension<UIColors>()!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    //
    // final size = MediaQuery.of(context).size;
    // int width = size.width.toInt();
    // int height = size.height.toInt();
    //
    // String gg = "w : $width, h : $height";

    return GetBuilder<NetController>(
        builder: (NetController controller) {

          eNetworkState?  networkState = controller.networkStatus;

          // print("awdawdwa");
          //
          // return Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //   color: Colors.blueGrey[900],  // 배경색 설정
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(Icons.light_mode, color: networkState == eNetworkState.Connected ? Colors.green : Colors.white),
          //       SizedBox(width: 5),
          //       Text(
          //         networkState == eNetworkState.Connected ? "Connected" : "None",
          //         style: TextStyle(fontSize: 12, color: Colors.white),
          //       ),
          //     ],
          //   ),
          // );

          //
          // return Container(
          //   color: Colors.blueGrey[900],  // 배경색 설정
          //   child: Padding(
          //     padding: const EdgeInsets.all(1),
          //     child: Column(
          //       children: [
          //         Expanded(  // 첫 번째 자식을 Flexible로 변경
          //           child: Align(
          //             alignment: Alignment.centerLeft,
          //             child: Text(
          //                 "Network Status",
          //                 style: TextStyle(fontSize: 12, color: Colors.green)
          //             ),
          //           ),
          //         ),
          //         Expanded(  // 두 번째 자식을 Flexible로 변경
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.end,
          //             children: [
          //               Spacer(),
          //               Icon(Icons.light_mode, color: networkState == eNetworkState.Connected ? Colors.green : Colors.white),
          //               SizedBox(width: 5),
          //               Text(
          //                   networkState == eNetworkState.Connected ? "Connected" : "None",
          //                   style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white)
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // );


          return Container(
            color: Colors.blueGrey[900],  // 배경색 설정
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.transparent, // 내부 색상 투명
                        border: Border.all(color: Colors.green, width: 2), // 녹색 테두리
                        borderRadius: BorderRadius.circular(4) // 모서리를 둥글게
                    ),
                    width: 280.0,  // 컨테이너의 폭을 최대로 확장
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,  // 자식들 사이의 공간 최대로 확장
                      children: [
                        Text(
                            //gg , //"Network Status",  // 상태 제목
                            "Network Status",
                            style: TextStyle(fontSize: 12, color: Colors.green)  // 녹색 글씨
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.light_mode, color: networkState == eNetworkState.Connected ? Colors.green : Colors.white),  // 아이콘
                            SizedBox(width: 5),  // 아이콘과 텍스트 사이 간격
                            Text(
                                networkState == eNetworkState.Connected ? "Connected" : "None",  // 네트워크 상태 값
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: networkState == eNetworkState.Connected ? Colors.green : Colors.white)  // 큰 흰색 글씨
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );

          //
          // return Container(
          //   color: Colors.blueGrey[900],
          //   child: Padding(
          //     padding: const EdgeInsets.all(1),
          //     child: Column(
          //       children: [
          //         Row(
          //           children: [
          //             Container(
          //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //               decoration: BoxDecoration(
          //                   color: Colors.transparent,
          //                   border: Border.all(color: Colors.green, width: 2),
          //                   borderRadius: BorderRadius.circular(4)
          //               ),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start, // 자식들을 시작 지점에서 정렬
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Text(
          //                       "Network Status",
          //                       style: TextStyle(fontSize: 12, color: Colors.white)
          //                   ),
          //                   Row(
          //                     mainAxisSize: MainAxisSize.min,
          //                     children: [
          //                       Icon(Icons.light_mode, color: networkState == eNetworkState.Connected ? Colors.green : Colors.white),
          //                       SizedBox(width: 5),
          //                       Text(
          //                           networkState == eNetworkState.Connected ? "Connected" : "None",
          //                           style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white)
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // );


          //
          //
          // return Container(
          //   // 전체 컨테이너 스타일
          //   color: Colors.blueGrey[900], // 배경색 설정
          //   child: Padding(
          //     padding: const EdgeInsets.all(1),
          //     child: Column(
          //       children: [
          //         Row(
          //           children: [
          //             // SizedBox(width: 40),
          //             // 네트워크 상태를 표시하는 텍스트와 아이콘
          //             Container(
          //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //               decoration: BoxDecoration(
          //                   color: Colors.transparent, // 내부 색상 투명
          //                   border: Border.all(color: Colors.green, width: 2), // 녹색 테두리
          //                   borderRadius: BorderRadius.circular(4) // 모서리를 둥글게
          //               ),
          //               child: Row(
          //                 mainAxisSize: MainAxisSize.min, // 내용물 크기에 맞춤
          //                 children: [
          //                   Icon(Icons.light_mode, color: networkState == eNetworkState.Connected ? Colors.green : Colors.white), // 아이콘
          //                   SizedBox(width: 5), // 아이콘과 텍스트 사이 간격
          //                   Align(
          //                     alignment: Alignment.topCenter,
          //                     child: Text(
          //                         "Network Status", // 상태 제목
          //                         style: TextStyle(fontSize: 12, color: Colors.white) // 작은 흰색 글씨
          //                     ),
          //                   ),
          //                   SizedBox(width: 10), // 상태 제목과 상태 값 사이 간격
          //                   Text(networkState == eNetworkState.Connected ? "Connected" : "None", // 네트워크 상태 값
          //                       // E_NetworkState.getValue(networkState), // 실제 네트워크 상태 값
          //                       style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white) // 큰 흰색 글씨
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             // 추가적인 UI 요소들을 이곳에 배치할 수 있습니다.
          //           ],
          //         ),
          //         // 다른 Row나 Column 요소를 여기에 추가할 수 있습니다.
          //       ],
          //     ),
          //   ),
          // );

        }

    );
  }


}


