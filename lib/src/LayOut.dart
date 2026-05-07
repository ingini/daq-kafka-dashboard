import 'package:daq_dashboard/src/meta/MediaEventDefines.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/ui/customEventContainer.dart';
import 'package:daq_dashboard/src/widgets/LayoutTemplate.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/widgets/NotificationOverlayWidget.dart';
import 'package:daq_dashboard/src/widgets/PopupDisplayWidget.dart';
import 'package:daq_dashboard/src/widgets/VoiceRecordingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// ── 화면 분할 ─────────────────────────────────────────────────
// 전체: 2960 × 1848
//
// 왼쪽 메인 영역: 2220w
//   ┌───────────────────────────────────────────────────┐
//   │  [cam0 좌] 460w×259h   [cam1 중앙]   [cam2 우]   │  top 32h
//   │                                                   │
//   │           (하단 여백 / 추후 확장)                  │
//   └───────────────────────────────────────────────────┘
//
// 오른쪽 패널: 740w
//   ┌──────────────┐
//   │  NetStatus   │  top 32h
//   │  GNSS        │  top 501h
//   │  Storage     │  top 1238h
//   │  Acquisition │  top 1654h
//   └──────────────┘

// 카메라 1대 크기: 460w × 259h
// 3대 합산: 1380w  +  여백 2×20w = 1420w
// 3대 좌측 시작 오프셋: (2220 - 1420) / 2 = 400w  → 중앙 정렬
const double _camW     = 460;
const double _camH     = 259;
const double _camGap   = 20;   // 카메라 사이 간격
const double _camTop   = 32;
const double _camStart = 400;  // 2220 기준 좌측 여백 (3대 중앙 정렬)


class LayOut extends StatefulWidget {
  @override
  _LayOutState createState() => _LayOutState();
}

class _LayOutState extends State<LayOut> {

  static const platform = MethodChannel(MediaEventDefines.MethodChannel);

  customEventContainer _customEventContainer = customEventContainer();

  @override
  void initState() {
    super.initState();
    _customEventContainer.append(eWidgetID.VoiceRecord,      GlobalKey<VoiceRecordWidgetState>());
    _customEventContainer.append(eWidgetID.VoiceRecordPopup, GlobalKey<VoiceRecordingPopupWidgetState>());
    platform.setMethodCallHandler(_handleMethodCall);
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    if (call.method == MediaEventDefines.MediaButton) {
      final int keyCode = call.arguments;
      _handleMediaButton(keyCode);
    }
  }

  void _handleMediaButton(int keyCode) {
    _customEventContainer.container.forEach((key, value) {
      value.currentState?.onButtonDown(keyCode);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width:  Defines.const_screen_width.w,
        height: Defines.const_screen_height.h,
        child: Stack(
          children: [

            // ── 메인 레이아웃 (좌/우 분할) ────────────────────
            Row(
              children: [

                // ── 왼쪽 메인 영역 2220w ─────────────────────
                Container(
                  width:  2220.w,
                  height: Defines.const_screen_height.h,
                  color:  Colors.black,
                  child: Stack(
                    children: [

                      // cam0 — 좌
                      Positioned(
                        top:  _camTop.h,
                        left: _camStart.w,
                        child: LayoutTemplate(
                          widgetType: eWidgetType.Camera,
                          tag: eTags.cam0,
                          bClipRect: true,
                        ),
                      ),

                      // cam1 — 중앙
                      Positioned(
                        top:  _camTop.h,
                        left: (_camStart + _camW + _camGap).w,
                        child: LayoutTemplate(
                          widgetType: eWidgetType.Camera,
                          tag: eTags.cam1,
                          bClipRect: true,
                        ),
                      ),

                      // cam2 — 우
                      Positioned(
                        top:  _camTop.h,
                        left: (_camStart + (_camW + _camGap) * 2).w,
                        child: LayoutTemplate(
                          widgetType: eWidgetType.Camera,
                          tag: eTags.cam2,
                          bClipRect: true,
                        ),
                      ),

                    ],
                  ),
                ),

                // ── 오른쪽 패널 740w ──────────────────────────
                Container(
                  width:  740.w,
                  height: Defines.const_screen_height.h,
                  color:  Colors.black,
                  child: Stack(
                    children: [

                      // NetStatus
                      Positioned(
                        top:  32.34.h,
                        left: 0.w,
                        child: LayoutTemplate(
                          widgetType: eWidgetType.NetStatus,
                          tag: eTags.netStatus,
                          bClipRect: true,
                        ),
                      ),

                      // GNSS
                      Positioned(
                        top:  501.27.h,
                        left: 0.w,
                        child: LayoutTemplate(
                          widgetType: eWidgetType.GNSS,
                          tag: eTags.gnss,
                          bClipRect: true,
                        ),
                      ),

                      // Storage
                      Positioned(
                        top:  1238.16.h,
                        left: 0.w,
                        child: LayoutTemplate(
                          widgetType: eWidgetType.Storage,
                          tag: eTags.storage,
                          bClipRect: true,
                        ),
                      ),

                      // Acquisition (수집 시작 / 수집 종료)
                      Positioned(
                        top:  1653.96.h,
                        left: 0.w,
                        child: LayoutTemplate(
                          widgetType: eWidgetType.Acquisition,
                          tag: eTags.acquisition,
                          bClipRect: true,
                          borderColor: null,
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),

            // ── 버전 표시 ─────────────────────────────────────
            Positioned(
              bottom: 20.96.h,
              left:   10.w,
              child:  UIComponents.version(),
            ),

            // ── 팝업 / 알림 오버레이 ──────────────────────────
            PopupDisplayWidget(
              tag_name: MetaPropertyManager().getTagName(eTags.popup)!,
            ),

            NotificationOverlayWidget(),

            Positioned(
              top:  10.h,
              left: 10.w,
              child: LayoutTemplate(
                widgetType: eWidgetType.Notification,
                tag: eTags.notification,
                bClipRect: true,
                borderColor: null,
              ),
            ),

            // ── Voice Record ──────────────────────────────────
            Positioned(
              top:  100.h,
              left: 150.w,
              child: VoiceRecordWidget(
                key: _customEventContainer.getValueFromID(eWidgetID.VoiceRecord),
                taggingTag: eTags.voice_record,
              ),
            ),

            Positioned(
              top:  Defines.recodingPopupOffset.dy,
              left: Defines.recodingPopupOffset.dx,
              child: VoiceRecordingPopupWidget(
                key: _customEventContainer.getValueFromID(eWidgetID.VoiceRecordPopup),
                taggingTag: eTags.voice_record,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
