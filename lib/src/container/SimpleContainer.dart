import 'package:flutter/material.dart';

import 'package:daq_dashboard/src/store/constant.dart';

class SimpleContainer<T> extends StatefulWidget {
  const SimpleContainer({
    super.key,
    required this.viewModel,
    required this.child,
  });

  final T viewModel;
  final Widget child;

  @override
  State<SimpleContainer> createState() => _SimpleContainer();
}

class _SimpleContainer extends State<SimpleContainer> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.viewModel.device.name, style: Theme.of(context).textTheme.headlineSmall),
                    Text(widget.viewModel.device.address, style: Theme.of(context).textTheme.bodyMedium)
                  ]
              ),
              containerSpace,
              const Spacer()
            ],
          ),
          containerSpace,
          Flexible(child: widget.child)
        ],
      ),
    );
  }
}
