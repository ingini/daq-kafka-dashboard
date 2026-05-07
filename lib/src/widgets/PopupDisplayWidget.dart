

import 'package:daq_dashboard/src/Controllers/PopupController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PopupDisplayWidget extends StatelessWidget {
  final String tag_name;
  PopupDisplayWidget({required this.tag_name});


  // final PopupController popupController = Get.find();

  @override
  Widget build(BuildContext context) {

    final PopupController popupController = Get.find(tag: tag_name);

    return Obx(() {
      return Stack(
        children: popupController.popups
            .asMap()
            .entries
            .map((entry) {
          int index = entry.key;
          PopupModel popup = entry.value;
          return Positioned(
            top:0,
            bottom: 0,
            left: 0,
            right: 0,
            // top: 100.0 + (index * 60), // 각 팝업을 아래로 약간씩 이동
            // left: 50.0,
            // right: 50.0,
            child: AlertDialog(
              title: Text(popup.title),
              content: Text(popup.message),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    popupController.closePopup(index);
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }
}