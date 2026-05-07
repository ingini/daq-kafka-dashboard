
import 'dart:convert';

import 'package:daq_dashboard/src/dataObjects/idto.dart';
import 'package:daq_dashboard/src/dtos/ConnectInfoDTO.dart';
import 'package:daq_dashboard/src/dtos/PingDTO.dart';
import 'package:daq_dashboard/src/dataObjects/IJSon.dart';
import 'package:daq_dashboard/src/dtos/JSonFactory.dart';
import 'package:flutter/services.dart';

import '../utils/enumHelper.dart';

import 'package:daq_dashboard/src/meta/enums.dart';



enum eConfigKey
{
  server_address,
  port,

  net_interval,

  run_mode,

  ping,

  ping_gateway,
  ping_wan,
  ping_cpu,

  ping__name,
  ping__address,

  daq_edge,
  daq_edge_address,
  daq_edge_port,
  daq_edge_user_name,
  daq_edge_password,
  daq_edge_workdir,
  daq_edge_active,
  daq_edge_docker_compose_file,

}

cEnum<eConfigKey, String> ConfigType() {
  var _queue = cEnum<eConfigKey, String>();
  _queue.push(eConfigKey.server_address, 'server_address');
  _queue.push(eConfigKey.port, 'port');
  _queue.push(eConfigKey.net_interval, 'net_interval');

  _queue.push(eConfigKey.run_mode, 'run_mode');

  _queue.push(eConfigKey.ping, 'ping');
  _queue.push(eConfigKey.ping_gateway, 'gateway');
  _queue.push(eConfigKey.ping_wan, 'wan');
  _queue.push(eConfigKey.ping_cpu, 'cpu');
  _queue.push(eConfigKey.ping__name, 'name');
  _queue.push(eConfigKey.ping__address, 'address');

  _queue.push(eConfigKey.daq_edge, 'daq_edge');
  _queue.push(eConfigKey.daq_edge_address, 'address');
  _queue.push(eConfigKey.daq_edge_port, 'port');
  _queue.push(eConfigKey.daq_edge_user_name, 'user_name');
  _queue.push(eConfigKey.daq_edge_password, 'password');
  _queue.push(eConfigKey.daq_edge_workdir, 'work_dir');
  _queue.push(eConfigKey.daq_edge_active, 'active');
  _queue.push(eConfigKey.daq_edge_docker_compose_file, 'docker_compose_filename');

  return _queue;
}

cEnum<eConfigKey, String> eConfigType = ConfigType();


class ConfigUtil
{
  static final ConfigUtil _instance = ConfigUtil._internal();

  ConfigUtil._internal();

  static ConfigUtil get instance => _instance;

  Map<String, dynamic>? _config; // nullable 타입 유지

  Future<Map<String, dynamic>> get config async {
    if (_config == null) {
      _config = await loadConfig();
    }
    return _config!;
  }





  void Initialize(){

  }


  Future<dynamic> getValue(eConfigKey _key) async {
    final config = await ConfigUtil.instance.config;
    dynamic value = config[eConfigType.getValue(_key)];
    return value;
  }

  dynamic getValueImmediately(eConfigKey _key) {
    final config = ConfigUtil.instance._config!;
    dynamic value = config[eConfigType.getValue(_key)];
    return value;
    // return config[eConfigType.getValue(_key)];
  }

  Future<IJSon> getPingDto(eConfigKey ping_target_key) async
  {
    final config = await ConfigUtil.instance.config;

    var jsonObject = config[ eConfigType.getValue(eConfigKey.ping) ][eConfigType.getValue(ping_target_key)];


    var dto = JSonFactory.fromJsonObjectTypeFactory(
        PingDTO.fromJsonObjectTypeCallback ,
        ePingTargetType.getPingTargetType(eConfigType.getValue(ping_target_key)) ,
        jsonObject);

    return dto;

  }

  Future<IDTO> getDaqEdgeDto() async
  {
    final config = await ConfigUtil.instance.config;
    DaqEdgeDTO dto = DaqEdgeDTO();

    dto.SetDaqEdgeDTOFromMap(config[ eConfigType.getValue(eConfigKey.daq_edge) ]);
    return dto;
  }


  Future<int> getInterval() async
  {
    return await getValue(eConfigKey.net_interval).then((value) => value as int);
  }

  static Future<Map<String, dynamic>> loadConfig() async {
    final jsonString = await rootBundle.loadString('assets/config.json');
    return json.decode(jsonString);
  }
}



//
//
//
// void main() async {
//
//   final config = await ConfigUtil.instance.config;
//   print(config['server_address']);
//
// }
//

