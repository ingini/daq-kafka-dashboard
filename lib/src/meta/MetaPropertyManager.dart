

import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';

class MetaPropertyElements {

  final eTags _group_tag;

  Map<eTags , metaProperty> _properties = {};

  MetaPropertyElements(eTags group_tag , List<metaProperty> properties)
      : _group_tag = group_tag
  {
    properties.forEach((element) {
      _properties[element.tag] = element;
    });
  }

  metaProperty? getMetaProperty(eTags tag) {
    return _properties[tag];
  }

  metaProperty? getMetaPropertyByTagName(String tag_name ) {

    for ( eTags key in _properties.keys) {
      if (_properties[key]!.tag_name == tag_name) {
        return _properties[key];
      }
    }
    return null;
  }

  eTags get group_tag => _group_tag;

  Map<eTags , metaProperty> get properties => _properties;

}


class MetaPropertyManager {
  static final MetaPropertyManager _instance = MetaPropertyManager._internal();
  factory MetaPropertyManager() => _instance;
  MetaPropertyManager._internal();

  final Map<eTags, MetaPropertyElements> _propertiyGroups = {};


  void Initialize() {
    Defines.getMetaProperties().forEach((key, value) {
      if (!_propertiyGroups.containsKey(key)) {
        _propertiyGroups[key] = MetaPropertyElements(key, value);
      }

    });
  }

  metaProperty? getMetaPropertyByGroupTag(eTags group_tag , eTags tag) {
    return _propertiyGroups[group_tag]?.getMetaProperty(tag);
  }

  MetaPropertyElements? getMetaPropertyElements(eTags group_tag ) {
    return _propertiyGroups[group_tag];
  }

  metaProperty? getMetaProperty(eTags tag) {
    for (var entry in _propertiyGroups.entries) {
      var result = entry.value.getMetaProperty(tag);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  String? getTagName(eTags tag) {
    for (var entry in _propertiyGroups.entries) {
      var result = entry.value.getMetaProperty(tag);
      if (result != null) {
        return result.tag_name;
      }
    }
    return null;
  }


  metaProperty? getMetaPropertyByTagName(String tag_name) {
    for (var entry in _propertiyGroups.entries) {
      var result = entry.value.getMetaPropertyByTagName(tag_name);
      if (result != null) {
        return result;
      }
    }
    return null;
  }


  String? getSensorName(String tag_name) {
    for (var entry in _propertiyGroups.entries) {
      var result = entry.value.getMetaPropertyByTagName(tag_name);
      if (result != null) {
        return result.sensor_name;
      }
    }
    return null;
  }


  String? getSensorHealthName(String tag_name) {
    for (var entry in _propertiyGroups.entries) {
      var result = entry.value.getMetaPropertyByTagName(tag_name);
      if (result != null) {
        return result.sensor_health_name;
      }
    }
    return null;
  }


  eTags? getTagType(String tag_name) {
    for (var entry in _propertiyGroups.entries) {
      var result = entry.value.getMetaPropertyByTagName(tag_name);
      if (result != null) {
        return result.tag;
      }
    }
    return null;
  }


  void TestPrintln()
  {
    MetaPropertyElements? elements = getMetaPropertyElements(eTags.lidar);

    elements?.properties.forEach((key, value) {
      print("key: $key, value: ${value.tag_name}");
    });

  }

}

//
// void main() {
//   print('Hello, World!');
// }

//
// void main(){
//   //
//   // MetaPropertyManager().Initialize();
//   //
//   // MetaPropertyManager().TestPrintln();
//
// }