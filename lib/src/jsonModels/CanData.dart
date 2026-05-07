


import 'dart:convert';

import 'package:daq_dashboard/src/dataObjects/IJSon.dart';

class CanData extends IJSon {

  int bytes_per_sec;

  CanData ({required this.bytes_per_sec});

  static CanData fromJsonCallback(String json_string) {
    var jsonDecode2 = jsonDecode(json_string);
    return CanData(
      bytes_per_sec: jsonDecode2['bytes_per_sec']
    );
  }

}