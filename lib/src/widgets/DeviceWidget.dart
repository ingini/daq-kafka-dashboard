import 'package:daq_dashboard/src/Controllers/DeviceController.dart';
import 'package:daq_dashboard/src/meta/AppManager.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/meta/Modes.dart';
import 'package:daq_dashboard/src/Models/DeviceModel.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:daq_dashboard/src/store/constant.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';

class DeviceWidget extends TaggingStatefulWidget {

  DeviceWidget( eTags taggingTag ) : super(taggingTag: taggingTag);

  @override
  TaggingWidgetState<DeviceWidget> createState() => _DeviceWidgetState(taggingMetaProperty);

}

class _DeviceWidgetState extends TaggingWidgetState<DeviceWidget> {
  _DeviceWidgetState(metaProperty taggingMetaProperty) : super(taggingMetaProperty);

  @override
  Widget build(BuildContext context) {
    final UIColors uiColors = Theme.of(context).extension<UIColors>()!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // taggingMetaPropert?y.tag;

    return GetBuilder<DeviceController>(
      tag: tag,
      builder: (DeviceController controller) {

        DeviceModel? model = controller.PopModel() as DeviceModel;

        // if(model == null) {
        //   print("mossdel Null");
        // }
        // else {
        //   print("model Not Null");
        //
        //   print(" "
        //       "llll :::  ${model.connection_state}");
        // }

        //
        //
        // print( "Device : " + model!.stateStack.toString() );
        //
        //
        // print("Device : ControlActive : " + model.IsStateSuccess(eProcessingState.ControlActive).toString());
        // print("Device : NetworkConnected : " + model.IsStateSuccess(eProcessingState.NetworkConnected).toString());
        // print("Device : DeviceConnected : " + model.IsStateSuccess(eProcessingState.DeviceConnected).toString());
        //


        return Container(
          color: null,
          child: Padding(
            padding: const EdgeInsets.all(0.1),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.light_mode, color: model.IsStateSuccess(eProcessingState.DeviceConnected) ? uiColors.success : colorScheme.error ),
                    // Icon(Icons.light_mode, color: model.connection_state == Connection_State.CONNECTED ? uiColors.success : colorScheme.error ),
                    // Icon(Icons.light_mode, color: uiColors.success  ),
                    // widget.viewModel.device.pingStatus == PingStatus.SUCCESS ? uiColors.success : colorScheme.error),
                    containerSpace,
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(  taggingMetaProperty.display_name , style: Theme.of(context).textTheme.headlineSmall),
                          // Text("widget.viewModel.device.address", style: Theme.of(context).textTheme.bodyMedium)
                        ]
                    ),
                    // containerSpace,
                    // const Spacer()
                  ],
                ),
                // containerSpace,
                // Flexible(child: widget._child)
              ],
            ),
          ),
        );
      }

    );
  }


}



