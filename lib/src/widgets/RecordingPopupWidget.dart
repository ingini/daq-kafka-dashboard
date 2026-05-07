import 'package:daq_dashboard/src/Controllers/RecordingController.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


class VoiceRecordingPopupWidget  extends TaggingStatefulWidget {

  VoiceRecordingPopupWidget( {Key? key,required eTags taggingTag} ) : super( key: key ,taggingTag : taggingTag);

  @override
  VoiceRecordingPopupWidgetState createState() => VoiceRecordingPopupWidgetState(taggingMetaProperty);

}

class VoiceRecordingPopupWidgetState extends TaggingWidgetState<VoiceRecordingPopupWidget> with SingleTickerProviderStateMixin {


  late AnimationController _controller;
  late Animation<double> _animation;


  VoiceRecordingPopupWidgetState(metaProperty taggingMetaProperty)
      : super(taggingMetaProperty);


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 600.w).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecordingController>(
      tag: tag,
      builder: (RecordingController controller) {

        if( !controller.isRecording ) {
          return Container();
        }

        return Center(
          child: Container(
            width: Defines.recodingPopupSzie.width,
            height: Defines.recodingPopupSzie.height,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.blue.withOpacity(0.9), Colors.transparent],
                radius: 0.8,
                center: Alignment.center,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 중앙에 마이크 아이콘
                Icon(
                  TablerIcons.microphone,
                  size: 120.w, // 아이콘 크기를 키움
                  color: Colors.white,
                ),
                // 원 그리기
                // 애니메이션 원
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return CustomPaint(
                      size: Size(Defines.recodingPopupSzie.width, Defines.recodingPopupSzie.height),
                      painter: CirclePainter(_animation.value),
                    );
                  },
                ),
                // 오른쪽 위 닫기 버튼
                Positioned(
                  top: 20.h,
                  right: 20.w,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white, size: 90.w),
                    onPressed: () async {
                      await controller.stopRecordingAsync();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> onButtonDown(int keyCode) async {
    await super.onButtonDown(keyCode);

    // print("22222222222");

    // if( keyCode == eMediaKey.PlayAndPause.value ) {
    //   await controller.toggleRecordingAsync();
    // }

    // await controller.startRecordingAsync();

  }

}

class CirclePainter extends CustomPainter {
  final double radius;

  CirclePainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6) // 불투명도를 높임
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.w; // 선의 두께를 키움

    // 중앙에 애니메이션 원 그리기
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}