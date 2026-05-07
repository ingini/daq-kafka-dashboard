import 'package:daq_dashboard/src/Controllers/NotificationController.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';

class NotificationOverlayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final notifications = Get.find<NotificationController>( tag: MetaPropertyManager().getMetaProperty(eTags.notification)!.tag_name  ).notifications;

      final isVisible = Get.find<NotificationController>( tag: MetaPropertyManager().getMetaProperty(eTags.notification)!.tag_name  ).isNotificationOverlayVisible.value;

      return Visibility(
        visible: isVisible,
        child: Stack(
          children: notifications
              .asMap()
              .map((index, notification) {
            final top = 50.0.h + (index * UIComponents.NotificationHeightGap.h );
            return MapEntry(
              index,
              Positioned(
                top: top,
                right: 10,
                child: _buildOverlayEntry(notification.message),
              ),
            );
          })
              .values
              .toList(),
        ),
      );
    });
  }

  Widget _buildOverlayEntry(String message) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        width: UIComponents.NotificationWidth.w,
        height: UIComponents.NotificationHeight.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: Border.all(color: Colors.black, width: 1.w),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 5.w, // 붉은 띠의 너비 설정
              height: double.infinity, // 붉은 띠의 높이 설정
              color: Colors.red,
            ),
            SizedBox(width: 8), // 붉은 띠와 텍스트 사이의 간격
            Text(
              message,
              style: TextStyle(color: Colors.black , fontSize: UIComponents.NotificationFontSize.sp),
              maxLines: null, // 줄바꿈 허용
              overflow: TextOverflow.clip, // 텍스트 넘침 허용
            ),
          ],
        ),
      ),
    );
  }
}