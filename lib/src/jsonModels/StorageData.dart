import 'dart:convert';

import 'package:daq_dashboard/src/dataObjects/IJSon.dart';



class StorageData extends  IJSon {
  int total = 0;
  int used = 0;
  int free = 0;

  StorageData({required this.total, required this.used, required this.free});


  static StorageData fromJsonCallback(String json_string)
  {
    var jsonDecode2 = jsonDecode(json_string);
    return StorageData(
      total: jsonDecode2['total'],
      used: jsonDecode2['used'],
      free: jsonDecode2['free'],
    );
  }
}


