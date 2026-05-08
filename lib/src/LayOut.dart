import 'package:daq_dashboard/src/meta/MediaEventDefines.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/ui/customEventContainer.dart';
import 'package:daq_dashboard/src/widgets/CameraFlipWidget.dart';
import 'package:daq_dashboard/src/widgets/IntergrationLidarWidget.dart';
import 'package:daq_dashboard/src/widgets/LayoutTemplate.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/widgets/NotificationOverlayWidget.dart';
import 'package:daq_dashboard/src/widgets/PopupDisplayWidget.dart';
import 'package:daq_dashboard/src/widgets/RecordingPopupWidget.dart';
import 'package:daq_dashboard/src/widgets/RightColorWidget.dart';
import 'package:daq_dashboard/src/widgets/VoiceRecordingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LayOut extends StatefulWidget {
  @override
  _LayOutState createState() => _LayOutState();
}



class _LayOutState extends State<LayOut> {
// class LayOut extends StatelessWidget {

  static const platform = MethodChannel(MediaEventDefines.MethodChannel);
  // String _lastKeyPressed = 'None';

  // //TODO 이부분은 Queue 안에 넣고 처리를 하는 방법으로
  // final GlobalKey<VoiceRecordWidgetState> _voiceRecordWidgetState = GlobalKey<VoiceRecordWidgetState>();
  // final GlobalKey<VoiceRecordingPopupWidgetState> _voiceRecordingPopupWidgetState = GlobalKey<VoiceRecordingPopupWidgetState>();
  // final GlobalKey<RightColorWidgetState> _rightColorWidgetState = GlobalKey<RightColorWidgetState>();

  customEventContainer _customEventContainer = customEventContainer();

  @override
  void initState() {
    super.initState();

    _customEventContainer.append( eWidgetID.VoiceRecord , GlobalKey<VoiceRecordWidgetState>());
    _customEventContainer.append( eWidgetID.VoiceRecordPopup , GlobalKey<VoiceRecordingPopupWidgetState>());

    platform.setMethodCallHandler(_handleMethodCall);

  }

  Future<void> _handleMethodCall(MethodCall call) async {
    if (call.method == MediaEventDefines.MediaButton)
    {
      final int keyCode = call.arguments;

      // setState(() {
      //   _lastKeyPressed = keyCode.toString();
      // });

      _handleMediaButton(keyCode);
    }
  }



  void _handleMediaButton(int keyCode) {
    // print("Key code: $keyCode");


    _customEventContainer.container.forEach((key, value) {
      value.currentState?.onButtonDown(keyCode);
    });

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body : Container(
        width: Defines.const_screen_width.w,
        height: Defines.const_screen_height.h,
        child: Stack(
          children: [
            Row(
            children: [
              Container(
                width: 2220.w,
                height: Defines.const_screen_height.h,
                color: Colors.black,
                child: Stack(
                  children: [
                    Positioned(
                        left: 0.w,
                        right: 0.w,
                        top: 0.h,
                        bottom: 0.h,
                        child: Container(

                          width: 1183.5.w,
                          height: 985.h,
                          // color: RunMode.IsDebug() ? Colors.green : null,
                          child:
                          // Text("Lidar")
                          IntergrationLidarWidget(eTags.lidar),
                        )
                    ),


                    // Positioned(
                    //   top: 32.h,
                    //   left: 383.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Camera, tag : eTags.cam_c_1 , bClipRect: true),
                    // ),

                    // cam0 — 좌
                    Positioned(
                      top: 32.h,
                      left: 396.w,
                      child: LayoutTemplate(widgetType : eWidgetType.Camera, tag : eTags.cam_a_1, bClipRect: true),
                    ),

                    // cam1 — 중앙
                    Positioned(
                      top: 32.h,
                      left: 878.w,
                      child: LayoutTemplate(widgetType : eWidgetType.Camera, tag : eTags.cam_a_2, bClipRect: true),
                    ),

                    // cam2 — 우
                    Positioned(
                      top: 32.h,
                      left: 1360.w,
                      child: LayoutTemplate(widgetType : eWidgetType.Camera, tag : eTags.cam_b_1, bClipRect: true),
                    ),

                    // Positioned(
                    //   top: 32.h,
                    //   left: 1373.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Camera, tag : eTags.cam_c_2, bClipRect: true),
                    // ),
                    //
                    //
                    //
                    Positioned(
                      top: 325.71.h,
                      left: 948.13.w,
                      child: LayoutTemplate(widgetType : eWidgetType.Lidar, tag : eTags.lidar_eth_e_a, bClipRect: true),
                    ),

                    Positioned(
                      top: 325.71.h,
                      left: 1126.19.w,
                      child: LayoutTemplate(widgetType : eWidgetType.Lidar, tag : eTags.lidar_eth_e_e, bClipRect: true),
                    ),


                    //
                    //
                    //
                    // Positioned(
                    //   top: 501.27.h,
                    //   left: 32.38.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Camera, tag : eTags.cam_c_4, bClipRect: true),
                    // ),
                    //
                    // Positioned(
                    //   top: 794.64.h,
                    //   left: 32.38.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Camera, tag : eTags.cam_b_4, bClipRect: true),
                    // ),
                    //
                    // Positioned(
                    //   top: 1088.01.h,
                    //   left: 32.38.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Camera, tag : eTags.cam_b_2, bClipRect: true),
                    // ),

                    //
                    // //
                    // Positioned(
                    //   top: 762.3.h,
                    //   left: 527.25.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Lidar, tag : eTags.lidar_eth_e_d, bClipRect: true),
                    // ),
                    //
                    // Positioned(
                    //   top: 940.17.h,
                    //   left: 527.25.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Lidar, tag : eTags.lidar_eth_e_l, bClipRect: true),
                    // ),

                    //
                    //
                    //
                    // Positioned(
                    //   top: 501.27.h,
                    //   left: 1725.13.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Camera, tag : eTags.cam_c_3, bClipRect: true),
                    // ),
                    //
                    // Positioned(
                    //   top: 794.64.h,
                    //   left: 1725.13.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Camera, tag : eTags.cam_b_3, bClipRect: true),
                    // ),
                    //
                    // Positioned(
                    //   top: 1088.01.h,
                    //   left: 1725.13.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Camera, tag : eTags.cam_b_1, bClipRect: true),
                    // ),
                    //
                    //
                    //
                    // //
                    // Positioned(
                    //   top: 762.3.h,
                    //   left: 1547.06.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Lidar, tag : eTags.lidar_eth_e_e, bClipRect: true),
                    // ),
                    //
                    // Positioned(
                    //   top: 940.17.h,
                    //   left: 1547.06.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Lidar, tag : eTags.lidar_eth_e_j, bClipRect: true),
                    // ),
                    //

                    //
                    //
                    // Positioned(
                    //   top: 1554.63.h,
                    //   left: 878.75.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.RearCamera, tag : eTags.cam_a_2, bClipRect: true),
                    // ),
                    //
                    //
                    // //
                    // Positioned(
                    //   top: 1376.76.h,
                    //   left: 948.13.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Lidar, tag : eTags.lidar_eth_e_c, bClipRect: true),
                    // ),
                    //
                    // Positioned(
                    //   top: 1376.76.h,
                    //   left: 1126.19.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.Lidar, tag : eTags.lidar_eth_e_k, bClipRect: true),
                    // ),
                    //
                    //
                    // // rear camera flip button
                    // Positioned(
                    //     top: 1600.63.h,
                    //     left: 1400.75.w,
                    //   child: CameraFlipWidget(eTags.cam_a_2),
                    //   )

                    // Positioned(
                    //     top: 1376.76.h,
                    //   left: 2220.w,
                    //   child: Container(
                    //     color: Colors.white,
                    //   )
                    // ),

                    // Positioned(
                    //   top: 32.34.h,
                    //   left: 2220.w,
                    //   child: LayoutTemplate(widgetType : eWidgetType.NetStatus,tag : eTags.netStatus),
                    // ),

                  ],
                ),

              ),
              Container(
                width: 740.w,
                height: Defines.const_screen_height.h,
                color: Colors.black,
                child: Stack(
                  children: [
                    Positioned(
                      top: 32.34.h,
                      left: 0.w,
                      child: LayoutTemplate(widgetType : eWidgetType.NetStatus,tag : eTags.netStatus, bClipRect: true),
                    ),

                    Positioned(
                      top: 32.34.h,
                      left: 402.38.w,
                      child: LayoutTemplate(widgetType : eWidgetType.Can,tag : eTags.can, bClipRect: true),
                    ),


                    //GNSS
                    Positioned(
                      top: 501.27.h,
                      left: 0.w,
                      child: LayoutTemplate(widgetType : eWidgetType.GNSS,tag : eTags.gnss, bClipRect: true),
                    ),

                    //storage
                    Positioned(
                      top: 1238.16.h,
                      left: 0.w,
                      child: LayoutTemplate(widgetType : eWidgetType.Storage,tag :  eTags.storage, bClipRect: true),
                    ),

                    //acquisition
                    Positioned(
                      top: 1653.96.h,
                      left: 0.w,
                      child: LayoutTemplate(widgetType : eWidgetType.Acquisition, tag : eTags.acquisition , bClipRect: true,borderColor: null),
                    ),



                  ],
                ),
              ),



            ],
          ),

            //version
            Positioned(
              bottom: 20.96.h,
              left: 10.w,
              child: UIComponents.version(),
            ),


            // 이부분에 팝업이 들어가면됨
            PopupDisplayWidget(tag_name:MetaPropertyManager().getTagName( eTags.popup )!),

            NotificationOverlayWidget(), // 알림 오버레이 추가

            Positioned(
                top: 10.h,
                left: 10.w,
                child:LayoutTemplate(widgetType : eWidgetType.Notification, tag : eTags.notification , bClipRect: true,borderColor: null),
              ) ,

            // append to voice recording button

            // Positioned(
            //   top: 10,
            //   left: 50,
            //   child:LayoutTemplate(widgetType : eWidgetType.VoiceRecordBtn, tag : eTags.voice_record_btn , bClipRect: true,borderColor: null),
            // ) ,
            //
            Positioned(
                top: 100.h,
                left: 150.w,
                child: VoiceRecordWidget(key: _customEventContainer.getValueFromID(eWidgetID.VoiceRecord) , taggingTag:eTags.voice_record),
            ),


            Positioned(
              top: Defines.recodingPopupOffset.dy ,
              left: Defines.recodingPopupOffset.dx ,
              child: VoiceRecordingPopupWidget(key: _customEventContainer.getValueFromID(eWidgetID.VoiceRecordPopup) ,taggingTag : eTags.voice_record ),
            ),

            // Positioned(
            //   top: Defines.recodingPopupOffset.dy ,
            //   left: Defines.recodingPopupOffset.dx ,
            //   child: RightColorWidget(key: _rightColorWidgetState ),
            // )

          ]
      ),
    )  ,

  );



  }
}