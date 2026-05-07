import 'dart:convert';

import 'package:daq_dashboard/src/dataObjects/IJSon.dart';

class GnssData extends  IJSon {
  double lat;
  double lon;
  int solnsvs;

  GnssData({required this.lat, required this.lon, required this.solnsvs});


  static GnssData fromJsonCallback(String json_string)
  {
      var jsonDecode2 = jsonDecode(json_string);
      return GnssData(
        lat: jsonDecode2['lat'],
        lon: jsonDecode2['lon'],
        solnsvs: jsonDecode2['solnsvs'],
      );
  }
}


//
// void main(){
//   var json_string = '{"lat": 37.1234, "lon": 127.1234, "solnsvs": 10}';
//   var gnssData = GnssData.fromJson(json_string);
//   print(gnssData.lat);
//   print(gnssData.lon);
//   print(gnssData.solnsvs);
//
//
// }