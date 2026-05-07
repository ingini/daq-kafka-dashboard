
import 'package:daq_dashboard/src/store/constant.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ImageCanvasConsumeGateWay.dart';

class UICamWidget extends StatefulWidget {

  final String _tag;

  const UICamWidget( String tag)
      : _tag = tag;


  @override
  _UICamWidgetState createState() => _UICamWidgetState(_tag);
}

class _UICamWidgetState extends State<UICamWidget> {

  final String _tag;

  _UICamWidgetState(this._tag);


  @override
  Widget build(BuildContext context) {
    final UIColors uiColors = Theme.of(context).extension<UIColors>()!;

    return Stack(
      children: [
      Positioned.fill(
        child:
        FractionallySizedBox(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            child: ImageCanvasConsumeGateWay(_tag)
          ),
          )
      ),
        Positioned(
            left: 0,
            child: ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: uiColors.success,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(buttonBorderRadius)
                    )
                ),
                child: Text(_tag, style: Theme.of(context).textTheme.titleLarge)
            )
        ),
        Align(
          alignment: Alignment.topRight,
          child: Text(
            'widget.viewModel.device.viewStatus' + '  ',// == LoggingStatus.ERROR ? 'Error !' : '',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            //widget.viewModel.device.loggingStatus == LoggingStatus.ERROR ? 'Error !' : '',
            'tcpdump: ' + 'widget.viewModelDaq.device.dumpStatus' + '  ',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: IconButton(
              onPressed: () => {
                //widget.viewModelDaq.setLoggingStatus(widget.viewModelDaq.device.dumpStatus),
                 },
              icon: Icon(
                'widget.viewModelDaq.device.dumpStatus' == 'sleeping' ? Icons.stop : Icons.play_arrow,
              )
          ),
        ),
      ],

    );
  }
}