import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:flutter/widgets.dart';

abstract class TaggingStatefulWidget extends StatefulWidget {

  late metaProperty _taggingMetaProperty;

  TaggingStatefulWidget( {Key? key, required eTags taggingTag })
   : super(key: key ){
    _taggingMetaProperty = MetaPropertyManager().getMetaProperty(taggingTag)!;

  }

  metaProperty get taggingMetaProperty => _taggingMetaProperty;

  @override
  TaggingWidgetState createState();

}

// abstract class TaggingWidgetState extends State {
abstract class TaggingWidgetState<T extends TaggingStatefulWidget> extends State<T> {
  final metaProperty _taggingMetaProperty;

  TaggingWidgetState(this._taggingMetaProperty);


  String get tag => _taggingMetaProperty.tag_name;

  metaProperty get taggingMetaProperty => _taggingMetaProperty;


  Future<void> onButtonDown(int keyCode) async {
    // print("*************************onButtonDown : $keyCode");
  }


}