
// import 'dart:ui' as ui;

import 'package:daq_dashboard/src/dataObjects/idto.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:daq_dashboard/src/protos/daq-service.pbenum.dart';
import 'package:daq_dashboard/src/utils/QueuePool.dart';

class ConnectionDTO implements IDTO
{

  String _name;
  Connection_State _state;

  ConnectionDTO(this._name, this._state);

  String get name => _name;
  Connection_State get state => _state;



}