





import 'package:daq_dashboard/src/Controllers/CameraController.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/TaggingStatelessWidget.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CameraFlipWidget extends TaggingStatelessWidget  {

  CameraFlipWidget(eTags taggingTag) :
    super(taggingTag);



  @override
  Widget build(BuildContext context) {

    final CameraController controller = Get.find(tag: tag);

    return Container(

      child: GestureDetector(
        onTap: controller.toggleFlip,
          child: GetBuilder<CameraController>(
            tag: tag,
            builder: (CameraController controller) {
              return UIComponents.imageFlipButtonIcon(controller.getIsFlipped());
            }
          )
      ),
    );
  }

}