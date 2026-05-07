



import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:dart_ping/dart_ping.dart';

class DeviceModel extends SensorModel {



  DeviceModel(String tag)
      : super(tag);

  String get deviceName => sensor_name;



  //getter setter





  // Connection_State? get connection_state => _connection?.state;


}