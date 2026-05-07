//
//
//
// import 'package:daq_dashboard/src/Controllers/DeviceController.dart';
// import 'package:daq_dashboard/src/meta/Defines.dart';
// import 'package:daq_dashboard/src/meta/IProperty.dart';
// import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
//
// class TestDevStatefulWidget extends TaggingStatefulWidget {
//
//   TestDevStatefulWidget(eTags taggingTag) : super(taggingTag);
//
//   @override
//   TestDevWidgetState createState() => TestDevWidgetState(taggingMetaProperty);
// }
//
//
// class TestDevWidgetState extends TaggingWidgetState<TestDevStatefulWidget> {
//   TestDevWidgetState(metaProperty taggingMetaProperty) : super(taggingMetaProperty);
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return GetBuilder<DeviceController>(
//       tag: tag,
//       builder : (controller) {
//         return Container(
//           child: Text('TestDevWidgetState'),
//         );
//       }
//     ) ;
//
//   }
// }