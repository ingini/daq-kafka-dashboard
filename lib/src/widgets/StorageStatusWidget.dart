import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/ProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StorageStatusWidget extends StatelessWidget {

  final eWidgetStatus widgetStatus;

  final double total_t;
  final double used_t;
  final double free_t;

  StorageStatusWidget({
    required this.widgetStatus,
    required this.total_t,
    required this.used_t,
    required this.free_t,
  });

  Widget activeWidget (BuildContext context)
  {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          UIComponents.text("Total: ${total_t.toStringAsFixed(2)} TB"),
          SizedBox(height: 10), // 간격 추가
          UIComponents.text(" Used: ${used_t.toStringAsFixed(2)} TB"),
          SizedBox(height: 10), // 간격 추가
          UIComponents.text(" Free: ${free_t.toStringAsFixed(2)} TB"),
        ],
      );
  }

  Widget unActiveWidget (BuildContext context)
  {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          UIComponents.text("Total: -" , color:  UIComponents.IconColorFalse ),
          SizedBox(height: 10), // 간격 추가
          UIComponents.text(" Used: -", color:  UIComponents.IconColorFalse),
          SizedBox(height: 10), // 간격 추가
          UIComponents.text(" Free: -", color:  UIComponents.IconColorFalse),
        ],
      );
  }


  @override
  Widget build(BuildContext context) {


    if( widgetStatus == eWidgetStatus.Active)
      return activeWidget(context);
    else
      return unActiveWidget(context);
    //
    // return
    //   Column(
    //   crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     SizedBox(height: 10),
    //     UIComponents.text("text"),
    //     SizedBox(height: 10), // 간격 추가
    //     UIComponents.text("text"),
    //     SizedBox(height: 10), // 간격 추가
    //     UIComponents.text("text"),
    //   ],
    // );
  }




}