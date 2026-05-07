//
//  Generated code. Do not modify.
//  source: daq-service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Sensor_HealthCheck extends $pb.ProtobufEnum {
  static const Sensor_HealthCheck ENABLE = Sensor_HealthCheck._(0, _omitEnumNames ? '' : 'ENABLE');
  static const Sensor_HealthCheck UNABLE = Sensor_HealthCheck._(1, _omitEnumNames ? '' : 'UNABLE');

  static const $core.List<Sensor_HealthCheck> values = <Sensor_HealthCheck> [
    ENABLE,
    UNABLE,
  ];

  static final $core.Map<$core.int, Sensor_HealthCheck> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Sensor_HealthCheck? valueOf($core.int value) => _byValue[value];

  const Sensor_HealthCheck._($core.int v, $core.String n) : super(v, n);
}

class Connection_State extends $pb.ProtobufEnum {
  static const Connection_State UNKNOWN = Connection_State._(0, _omitEnumNames ? '' : 'UNKNOWN');
  static const Connection_State CONNECTED = Connection_State._(1, _omitEnumNames ? '' : 'CONNECTED');
  static const Connection_State DISCONNECTED = Connection_State._(2, _omitEnumNames ? '' : 'DISCONNECTED');

  static const $core.List<Connection_State> values = <Connection_State> [
    UNKNOWN,
    CONNECTED,
    DISCONNECTED,
  ];

  static final $core.Map<$core.int, Connection_State> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Connection_State? valueOf($core.int value) => _byValue[value];

  const Connection_State._($core.int v, $core.String n) : super(v, n);
}

class Health_Status extends $pb.ProtobufEnum {
  static const Health_Status UNKNOWN = Health_Status._(0, _omitEnumNames ? '' : 'UNKNOWN');
  static const Health_Status GOOD = Health_Status._(1, _omitEnumNames ? '' : 'GOOD');
  static const Health_Status WARN = Health_Status._(2, _omitEnumNames ? '' : 'WARN');
  static const Health_Status BAAD = Health_Status._(3, _omitEnumNames ? '' : 'BAAD');

  static const $core.List<Health_Status> values = <Health_Status> [
    UNKNOWN,
    GOOD,
    WARN,
    BAAD,
  ];

  static final $core.Map<$core.int, Health_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Health_Status? valueOf($core.int value) => _byValue[value];

  const Health_Status._($core.int v, $core.String n) : super(v, n);
}

class Acquisition_State extends $pb.ProtobufEnum {
  static const Acquisition_State UNKNOWN = Acquisition_State._(0, _omitEnumNames ? '' : 'UNKNOWN');
  static const Acquisition_State ACQUIRING = Acquisition_State._(1, _omitEnumNames ? '' : 'ACQUIRING');
  static const Acquisition_State NOT_ACQUIRING = Acquisition_State._(2, _omitEnumNames ? '' : 'NOT_ACQUIRING');

  static const $core.List<Acquisition_State> values = <Acquisition_State> [
    UNKNOWN,
    ACQUIRING,
    NOT_ACQUIRING,
  ];

  static final $core.Map<$core.int, Acquisition_State> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Acquisition_State? valueOf($core.int value) => _byValue[value];

  const Acquisition_State._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
