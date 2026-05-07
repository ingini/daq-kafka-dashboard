import 'package:daq_dashboard/src/Controllers/AcquisitionController.dart';
import 'package:daq_dashboard/src/Controllers/NotificationController.dart';
import 'package:daq_dashboard/src/Controllers/StorageController.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/StorageModel.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationControllWidget extends TaggingStatefulWidget {

  NotificationControllWidget( eTags taggingTag ) : super( taggingTag:taggingTag);

  @override
  TaggingWidgetState<NotificationControllWidget> createState() => _NotificationControllWidgetState(taggingMetaProperty);
}


class _NotificationControllWidgetState extends TaggingWidgetState<NotificationControllWidget> {

  _NotificationControllWidgetState(metaProperty taggingMetaProperty)
      : super(taggingMetaProperty);


  @override
  Widget build(BuildContext context) {
    // final UIColors uiColors = Theme.of(context).extension<UIColors>()!;

    return GetBuilder<NotificationController>(
        tag: tag,
        builder: (NotificationController controller) {
          return Container(
            child: GestureDetector(
              onTap:() async {
                controller.toggleNotificationOverlayVisibility();
              },
              child: Container(
                child: UIComponents.notificationBtn(controller.getNotificationOverlayVisibility())
              ),
            ),
          );
      }
    );
  }
}