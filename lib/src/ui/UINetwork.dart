import 'package:flutter/material.dart';

import 'package:daq_dashboard/src/container/BorderedContainer.dart';

class UINetwork<T> extends StatefulWidget {
  const UINetwork({super.key, required this.viewModel});

  final T viewModel;

  @override
  State<UINetwork> createState() => _UINetworkState();
}

class _UINetworkState extends State<UINetwork> {
  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
        viewModel: widget.viewModel,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      widget.viewModel.device.name,
                      style: Theme.of(context).textTheme.titleMedium)
              ),
            ),
            Flexible(
              child: Align(
                  alignment: Alignment.centerLeft, // 가운데 정렬
                  child: Text(
                      widget.viewModel.device.address,
                      style: Theme.of(context).textTheme.titleMedium)
              ),
            ),
          ],
        )
    );
  }
}
