import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/Models/TagModel.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';

class GnssModel extends SensorModel {
  //
  // String _sensor_name;
  //
  //
  // Connection? _connection;
  // Health? _health;
  // Acquisition? _acquisition;

  double? _latitude;
  double? _longitude;
  int? _solnsvs_count;

  GnssModel(String tag)
      : super(tag);

  //setter getter
  double? get latitude => _latitude;
  set latitude(double? value) {
    _latitude = value;
  }

  double? get longitude => _longitude;
  set longitude(double? value) {
    _longitude = value;
  }

  int? get solnsvs_count => _solnsvs_count;
  set solnsvs_count(int? value) {
    _solnsvs_count = value;
  }
  //
  // //setter getter
  // Connection? get connection => _connection;
  // set connection(Connection? value) {
  //   _connection = value;
  // }
  //
  // Connection_State? get connection_state => _connection?.state;
  //
  // Health? get health => _health;
  // set health(Health? value) {
  //   _health = value;
  // }
  //
  //
  // Acquisition? get acquisition => _acquisition;
  // set acquisition(Acquisition? value) {
  //   _acquisition = value;
  // }
  //
  // Acquisition_State? get acquisition_state => _acquisition?.state;


}

