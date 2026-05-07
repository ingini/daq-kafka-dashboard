import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/ProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StorageProgressBar extends StatelessWidget {
  final double height;   // min 30

  final eWidgetStatus widgetStatus;

  final double? proccing_percent1;   // min 30

  // final double? used_percent100;   // min 30

  final Color bg_color;
  final Color bar_color;

  double used_percent100 = 0;
  double free_percent100 = 0;

  StorageProgressBar({
    required this.widgetStatus,
    required this.proccing_percent1,
    required this.bg_color,
    required this.bar_color,
    this.height = 30,
  })
  {
    used_percent100 = proccing_percent1! * 100.0;
    free_percent100 = 100 -used_percent100;
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children :[
        Container(
          child: ProgressBar(
              proccing_percent: proccing_percent1,
              bg_color: bg_color,
              bar_color: bar_color,
            ),
        ),
        SizedBox(height: 10.h),
        if(widgetStatus == eWidgetStatus.UnActive)
          Container(
          child: Container()
          ),
        if(widgetStatus == eWidgetStatus.Active)
          Container(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: UIComponents.text("Uesd: ${used_percent100.toStringAsFixed(2)}%"),
                ),
                Container(
                  child: UIComponents.text("Free: ${free_percent100.toStringAsFixed(2)}%"),
                ),
              ],
            ),
          )
          ),
      ]
    );
  }




}