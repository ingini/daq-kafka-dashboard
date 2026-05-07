


import 'dart:convert';

import 'package:daq_dashboard/src/Configure/configUtil.dart';
import 'package:daq_dashboard/src/dataObjects/IJSon.dart';
import 'package:daq_dashboard/src/dataObjects/idto.dart';
import 'package:daq_dashboard/src/meta/enums.dart';

class PingDTO implements IDTO ,IJSon {


  late ePingTargetType targetType;


  String name;
  String address;

  PingDTO({required this.name, required this.address});


  static PingDTO fromJsonCallback(String json_string)
  {
    var jsonDecode2 = jsonDecode(json_string);
    return PingDTO(
      name: jsonDecode2[eConfigType.getValue(eConfigKey.ping__name)],
      address: jsonDecode2[eConfigType.getValue(eConfigKey.ping__address)],
    );
  }

  static PingDTO fromJsonObjectTypeCallback(ePingTargetType target_type , dynamic json_object) {

    PingDTO dto = PingDTO(
      name: json_object[eConfigType.getValue(eConfigKey.ping__name)],
      address: json_object[eConfigType.getValue(eConfigKey.ping__address)],
    );

    dto.targetType = target_type;

    return dto;
  }

  static PingDTO fromJsonTypeCallback(ePingTargetType target_type , String json_string) {

    var jsonDecode2 = jsonDecode(json_string);
    PingDTO dto = PingDTO(
      name: jsonDecode2[eConfigType.getValue(eConfigKey.ping__name)],
      address: jsonDecode2[eConfigType.getValue(eConfigKey.ping__address)],
    );
    
    dto.targetType = target_type;
    
    return dto;
  }

}
//
//
// main() {
//
//   JSonFactory.fromJsonFactory( PingDTO.fromJsonCallback , '{"name": "google", "address": "asd"}');
//
//   JSonFactory.fromJsonTypeFactory( PingDTO.fromJsonTypeCallback ,ePingTargetType.GateWay   , '{"name": "google", "address": "asd"}');
//
// }
//
