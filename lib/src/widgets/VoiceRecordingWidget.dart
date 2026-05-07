import 'dart:ffi';

import 'package:daq_dashboard/src/Controllers/RecordingController.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/meta/MediaEventDefines.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VoiceRecordWidget extends TaggingStatefulWidget {

  VoiceRecordWidget( {Key? key,required eTags taggingTag} ) : super(  key: key ,taggingTag : taggingTag );

  @override
  // TaggingWidgetState<VoiceRecordWidget> createState() => VoiceRecordWidgetState(taggingMetaProperty);
  VoiceRecordWidgetState createState() => VoiceRecordWidgetState(taggingMetaProperty);
  // TaggingWidgetState createState() => _VoiceRecordWidgetState(taggingMetaProperty);
}


class VoiceRecordWidgetState extends TaggingWidgetState<VoiceRecordWidget> {
// class _VoiceRecordWidgetState extends TaggingWidgetState {

  late RecordingController controller;

  VoiceRecordWidgetState(metaProperty taggingMetaProperty)
      : super(taggingMetaProperty);

  @override
  void initState() {
    super.initState();
    controller = Get.find<RecordingController>(tag: tag);
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<RecordingController>(
        tag: tag,
        builder: (RecordingController controller) {
          return Stack(
            children:[
              Container(
              child: GestureDetector(
                onTap:() async {
                  // print("p1");
                  await controller.startRecordingAsync();
                  // _showOverlay(context);
                },
                child: Container(
            
                    child: UIComponents.voiceRecordBtn(true),
                ),
              ),
            ),
          //
          // if (controller.recordingState == E_RecordingState.Recording)
          //   VoiceRecordingPopupWidget( eTags.voice_record_btn ), // 팝업 위젯 추가

          ]);
        });
  }
  @override
  Future<void> onButtonDown(int keyCode) async {
    await super.onButtonDown(keyCode);

    if( keyCode == eMediaKey.PlayAndPause.value ) {
      await controller.toggleRecordingAsync();
    }

    // await controller.startRecordingAsync();

  }

}