import 'package:flutter/material.dart';

import 'package:daq_dashboard/src/store/constant.dart';
import 'package:daq_dashboard/src/store/enum.dart';
import 'package:daq_dashboard/src/themes/theme.dart';

class BorderedContainer<T> extends StatefulWidget {
  const BorderedContainer({
    super.key,
    required this.viewModel,
    required this.child
  });

  final T viewModel;
  final Widget child;

  @override
  State<BorderedContainer> createState() => _BorderedContainerState();
}

class _BorderedContainerState extends State<BorderedContainer> {

  @override
  Widget build(BuildContext context) {
    final UIColors uiColors = Theme.of(context).extension<UIColors>()!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Card(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: widget.viewModel.device.pingStatus == PingStatus.SUCCESS ? uiColors.success! : colorScheme.error,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(cardBorderRadius)
        ),
        child: widget.child
    );
  }
}

