//
//  Generated code. Do not modify.
//  source: daq-service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'daq-service.pb.dart' as $0;

export 'daq-service.pb.dart';

@$pb.GrpcServiceName('protos.Service')
class ServiceClient extends $grpc.Client {
  static final _$ping = $grpc.ClientMethod<$0.void_, $0.void_>(
      '/protos.Service/ping',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.void_.fromBuffer(value));
  static final _$get_sensors = $grpc.ClientMethod<$0.void_, $0.Sensors>(
      '/protos.Service/get_sensors',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Sensors.fromBuffer(value));
  static final _$is_connected = $grpc.ClientMethod<$0.Sensor, $0.Connection>(
      '/protos.Service/is_connected',
      ($0.Sensor value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Connection.fromBuffer(value));
  static final _$is_healthy = $grpc.ClientMethod<$0.Sensor, $0.Health>(
      '/protos.Service/is_healthy',
      ($0.Sensor value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Health.fromBuffer(value));
  static final _$get_snapshot = $grpc.ClientMethod<$0.Sensor, $0.SensorSnapshot>(
      '/protos.Service/get_snapshot',
      ($0.Sensor value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SensorSnapshot.fromBuffer(value));
  static final _$get_snapshots = $grpc.ClientMethod<$0.void_, $0.SensorSnapshots>(
      '/protos.Service/get_snapshots',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SensorSnapshots.fromBuffer(value));
  static final _$is_acquiring = $grpc.ClientMethod<$0.Sensor, $0.Acquisition>(
      '/protos.Service/is_acquiring',
      ($0.Sensor value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Acquisition.fromBuffer(value));
  static final _$start_acquisition = $grpc.ClientMethod<$0.Sensor, $0.Acquisition>(
      '/protos.Service/start_acquisition',
      ($0.Sensor value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Acquisition.fromBuffer(value));
  static final _$stop_acquisition = $grpc.ClientMethod<$0.Sensor, $0.Acquisition>(
      '/protos.Service/stop_acquisition',
      ($0.Sensor value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Acquisition.fromBuffer(value));

  ServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.void_> ping($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$ping, request, options: options);
  }

  $grpc.ResponseFuture<$0.Sensors> get_sensors($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get_sensors, request, options: options);
  }

  $grpc.ResponseFuture<$0.Connection> is_connected($0.Sensor request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_connected, request, options: options);
  }

  $grpc.ResponseFuture<$0.Health> is_healthy($0.Sensor request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_healthy, request, options: options);
  }

  $grpc.ResponseFuture<$0.SensorSnapshot> get_snapshot($0.Sensor request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get_snapshot, request, options: options);
  }

  $grpc.ResponseFuture<$0.SensorSnapshots> get_snapshots($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get_snapshots, request, options: options);
  }

  $grpc.ResponseFuture<$0.Acquisition> is_acquiring($0.Sensor request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_acquiring, request, options: options);
  }

  $grpc.ResponseFuture<$0.Acquisition> start_acquisition($0.Sensor request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$start_acquisition, request, options: options);
  }

  $grpc.ResponseFuture<$0.Acquisition> stop_acquisition($0.Sensor request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$stop_acquisition, request, options: options);
  }
}

@$pb.GrpcServiceName('protos.Service')
abstract class ServiceBase extends $grpc.Service {
  $core.String get $name => 'protos.Service';

  ServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.void_, $0.void_>(
        'ping',
        ping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($0.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.void_, $0.Sensors>(
        'get_sensors',
        get_sensors_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($0.Sensors value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Sensor, $0.Connection>(
        'is_connected',
        is_connected_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Sensor.fromBuffer(value),
        ($0.Connection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Sensor, $0.Health>(
        'is_healthy',
        is_healthy_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Sensor.fromBuffer(value),
        ($0.Health value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Sensor, $0.SensorSnapshot>(
        'get_snapshot',
        get_snapshot_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Sensor.fromBuffer(value),
        ($0.SensorSnapshot value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.void_, $0.SensorSnapshots>(
        'get_snapshots',
        get_snapshots_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($0.SensorSnapshots value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Sensor, $0.Acquisition>(
        'is_acquiring',
        is_acquiring_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Sensor.fromBuffer(value),
        ($0.Acquisition value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Sensor, $0.Acquisition>(
        'start_acquisition',
        start_acquisition_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Sensor.fromBuffer(value),
        ($0.Acquisition value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Sensor, $0.Acquisition>(
        'stop_acquisition',
        stop_acquisition_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Sensor.fromBuffer(value),
        ($0.Acquisition value) => value.writeToBuffer()));
  }

  $async.Future<$0.void_> ping_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return ping(call, await request);
  }

  $async.Future<$0.Sensors> get_sensors_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return get_sensors(call, await request);
  }

  $async.Future<$0.Connection> is_connected_Pre($grpc.ServiceCall call, $async.Future<$0.Sensor> request) async {
    return is_connected(call, await request);
  }

  $async.Future<$0.Health> is_healthy_Pre($grpc.ServiceCall call, $async.Future<$0.Sensor> request) async {
    return is_healthy(call, await request);
  }

  $async.Future<$0.SensorSnapshot> get_snapshot_Pre($grpc.ServiceCall call, $async.Future<$0.Sensor> request) async {
    return get_snapshot(call, await request);
  }

  $async.Future<$0.SensorSnapshots> get_snapshots_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return get_snapshots(call, await request);
  }

  $async.Future<$0.Acquisition> is_acquiring_Pre($grpc.ServiceCall call, $async.Future<$0.Sensor> request) async {
    return is_acquiring(call, await request);
  }

  $async.Future<$0.Acquisition> start_acquisition_Pre($grpc.ServiceCall call, $async.Future<$0.Sensor> request) async {
    return start_acquisition(call, await request);
  }

  $async.Future<$0.Acquisition> stop_acquisition_Pre($grpc.ServiceCall call, $async.Future<$0.Sensor> request) async {
    return stop_acquisition(call, await request);
  }

  $async.Future<$0.void_> ping($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.Sensors> get_sensors($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.Connection> is_connected($grpc.ServiceCall call, $0.Sensor request);
  $async.Future<$0.Health> is_healthy($grpc.ServiceCall call, $0.Sensor request);
  $async.Future<$0.SensorSnapshot> get_snapshot($grpc.ServiceCall call, $0.Sensor request);
  $async.Future<$0.SensorSnapshots> get_snapshots($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.Acquisition> is_acquiring($grpc.ServiceCall call, $0.Sensor request);
  $async.Future<$0.Acquisition> start_acquisition($grpc.ServiceCall call, $0.Sensor request);
  $async.Future<$0.Acquisition> stop_acquisition($grpc.ServiceCall call, $0.Sensor request);
}
