
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class LayoutTemplate extends StatelessWidget {
  Widget? _contentWidget;

  final eWidgetType _widgetType;
  final widgetProperty? _widgetProporty;

  // final double borderRadius = 10.0.w;
  // final double borderWidth = 2.0.w;

  final double borderRadius = Defines.layOutBoarderRadius;
  final double borderWidth = Defines.layOutBoarderWidth;

  final Color? borderColor ;// = Colors.white54;

  bool _bclipRect = false;

  LayoutTemplate({ required eWidgetType widgetType ,
                   required eTags tag ,
                   required bool bClipRect,
                   this.borderColor = Colors.white54 })
  :  _widgetType = widgetType ,
     _widgetProporty = Defines.getWidgetProperty(widgetType),
        _bclipRect = bClipRect
  {
    _contentWidget = _widgetProporty!.createWidget(tag);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: _widgetProporty?.size.width == 0 ? null : _widgetProporty?.size.width,
      height: _widgetProporty?.size.height == 0 ? null : _widgetProporty?.size.height,


      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor == null ? Color(0x00000000)  : borderColor!,
          width: borderWidth,
        ),
      ),

      child : _bclipRect == true ? ClipRRect (borderRadius: BorderRadius.circular(borderRadius - 4.w),child: _contentWidget )  : _contentWidget,
      //
      // child: ClipRRect(
      //   borderRadius: BorderRadius.circular(borderRadius - 4.w), // 내부 둥글기는 조금 더 작게 설정
      //   child: _contentWidget, // 범용적으로 어떤 위젯도 받을 수 있도록 변경
      // ),
      //


    );
  }
}
