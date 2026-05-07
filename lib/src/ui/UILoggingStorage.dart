import 'package:daq_dashboard/src/container/BorderedContainer.dart';
import 'package:flutter/material.dart';

class UILoggingStorage<T> extends StatefulWidget {
  const UILoggingStorage({super.key, required this.viewModel});

  final T viewModel;

  @override
  State<UILoggingStorage> createState() => _UILoggingStorageState();
}

class _UILoggingStorageState extends State<UILoggingStorage> {
  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
        viewModel: widget.viewModel,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 1,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      widget.viewModel.device.name,
                      style: Theme.of(context).textTheme.titleSmall)
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 40),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: LinearProgressIndicator(
                    value: widget.viewModel.device.value2,
                    color: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Align(
                  alignment: Alignment.center, // 가운데 정렬
                  child: Text(
                      widget.viewModel.device.value1,
                      //'40 TB',
                      style: Theme.of(context).textTheme.titleMedium)
              ),
            ),
          ],
        )
    );
  }
}
