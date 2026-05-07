import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:flutter/widgets.dart';

abstract class TaggingStatelessWidget extends StatelessWidget {
  final metaProperty _taggingMetaProperty;

  TaggingStatelessWidget( eTags taggingTag ) /// this._taggingMetaProperty);
    : _taggingMetaProperty = MetaPropertyManager().getMetaProperty(taggingTag)!;

  metaProperty get taggingMetaProperty => _taggingMetaProperty;

  @override
  Widget build(BuildContext context);

  String get tag => _taggingMetaProperty.tag_name;
}