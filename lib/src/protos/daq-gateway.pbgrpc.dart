//
//  Generated code. Do not modify.
//  source: daq-gateway.proto
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

import 'daq-gateway.pb.dart' as $1;
import 'daq-service.pb.dart' as $0;

export 'daq-gateway.pb.dart';

@$pb.GrpcServiceName('ai.swm.trudy.daq.Gateway')
class GatewayClient extends $grpc.Client {
  static final _$ping = $grpc.ClientMethod<$0.void_, $0.void_>(
      '/ai.swm.trudy.daq.Gateway/ping',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.void_.fromBuffer(value));
  static final _$is_dev_connected = $grpc.ClientMethod<$1.Device, $0.Connection>(
      '/ai.swm.trudy.daq.Gateway/is_dev_connected',
      ($1.Device value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Connection.fromBuffer(value));
  static final _$is_all_dev_connected = $grpc.ClientMethod<$0.void_, $1.Connections>(
      '/ai.swm.trudy.daq.Gateway/is_all_dev_connected',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Connections.fromBuffer(value));
  static final _$is_dev_healthy = $grpc.ClientMethod<$1.Device, $0.Health>(
      '/ai.swm.trudy.daq.Gateway/is_dev_healthy',
      ($1.Device value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Health.fromBuffer(value));
  static final _$is_all_dev_healthy = $grpc.ClientMethod<$0.void_, $1.Healths>(
      '/ai.swm.trudy.daq.Gateway/is_all_dev_healthy',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Healths.fromBuffer(value));
  static final _$get_sensors = $grpc.ClientMethod<$0.void_, $0.Sensors>(
      '/ai.swm.trudy.daq.Gateway/get_sensors',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Sensors.fromBuffer(value));
  static final _$is_sensor_connected = $grpc.ClientMethod<$0.Sensor, $0.Connection>(
      '/ai.swm.trudy.daq.Gateway/is_sensor_connected',
      ($0.Sensor value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Connection.fromBuffer(value));
  static final _$is_all_sensor_connected = $grpc.ClientMethod<$0.void_, $1.Connections>(
      '/ai.swm.trudy.daq.Gateway/is_all_sensor_connected',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Connections.fromBuffer(value));
  static final _$is_sensor_healthy = $grpc.ClientMethod<$0.Sensor, $0.Health>(
      '/ai.swm.trudy.daq.Gateway/is_sensor_healthy',
      ($0.Sensor value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Health.fromBuffer(value));
  static final _$is_all_sensor_healthy = $grpc.ClientMethod<$0.void_, $1.Healths>(
      '/ai.swm.trudy.daq.Gateway/is_all_sensor_healthy',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Healths.fromBuffer(value));
  static final _$get_sensor_snapshot = $grpc.ClientMethod<$0.Sensor, $0.SensorSnapshot>(
      '/ai.swm.trudy.daq.Gateway/get_sensor_snapshot',
      ($0.Sensor value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SensorSnapshot.fromBuffer(value));
  static final _$get_all_sensor_snapshot = $grpc.ClientMethod<$0.void_, $0.SensorSnapshots>(
      '/ai.swm.trudy.daq.Gateway/get_all_sensor_snapshot',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SensorSnapshots.fromBuffer(value));
  static final _$is_sensor_acquiring = $grpc.ClientMethod<$0.Sensor, $0.Acquisition>(
      '/ai.swm.trudy.daq.Gateway/is_sensor_acquiring',
      ($0.Sensor value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Acquisition.fromBuffer(value));
  static final _$is_all_sensor_acquiring = $grpc.ClientMethod<$0.void_, $1.Acquisitions>(
      '/ai.swm.trudy.daq.Gateway/is_all_sensor_acquiring',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Acquisitions.fromBuffer(value));
  static final _$start_sensor_acquisition = $grpc.ClientMethod<$0.Sensor, $0.Acquisition>(
      '/ai.swm.trudy.daq.Gateway/start_sensor_acquisition',
      ($0.Sensor value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Acquisition.fromBuffer(value));
  static final _$start_all_sensor_acquisition = $grpc.ClientMethod<$0.void_, $1.Acquisitions>(
      '/ai.swm.trudy.daq.Gateway/start_all_sensor_acquisition',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Acquisitions.fromBuffer(value));
  static final _$stop_sensor_acquisition = $grpc.ClientMethod<$0.Sensor, $0.Acquisition>(
      '/ai.swm.trudy.daq.Gateway/stop_sensor_acquisition',
      ($0.Sensor value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Acquisition.fromBuffer(value));
  static final _$stop_all_sensor_acquisition = $grpc.ClientMethod<$0.void_, $1.Acquisitions>(
      '/ai.swm.trudy.daq.Gateway/stop_all_sensor_acquisition',
      ($0.void_ value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Acquisitions.fromBuffer(value));
  static final _$add_voice_tag = $grpc.ClientMethod<$1.VoiceTag, $0.void_>(
      '/ai.swm.trudy.daq.Gateway/add_voice_tag',
      ($1.VoiceTag value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.void_.fromBuffer(value));

  GatewayClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.void_> ping($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$ping, request, options: options);
  }

  $grpc.ResponseFuture<$0.Connection> is_dev_connected($1.Device request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_dev_connected, request, options: options);
  }

  $grpc.ResponseFuture<$1.Connections> is_all_dev_connected($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_all_dev_connected, request, options: options);
  }

  $grpc.ResponseFuture<$0.Health> is_dev_healthy($1.Device request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_dev_healthy, request, options: options);
  }

  $grpc.ResponseFuture<$1.Healths> is_all_dev_healthy($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_all_dev_healthy, request, options: options);
  }

  $grpc.ResponseFuture<$0.Sensors> get_sensors($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get_sensors, request, options: options);
  }

  $grpc.ResponseFuture<$0.Connection> is_sensor_connected($0.Sensor request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_sensor_connected, request, options: options);
  }

  $grpc.ResponseFuture<$1.Connections> is_all_sensor_connected($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_all_sensor_connected, request, options: options);
  }

  $grpc.ResponseFuture<$0.Health> is_sensor_healthy($0.Sensor request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_sensor_healthy, request, options: options);
  }

  $grpc.ResponseFuture<$1.Healths> is_all_sensor_healthy($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_all_sensor_healthy, request, options: options);
  }

  $grpc.ResponseFuture<$0.SensorSnapshot> get_sensor_snapshot($0.Sensor request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get_sensor_snapshot, request, options: options);
  }

  $grpc.ResponseFuture<$0.SensorSnapshots> get_all_sensor_snapshot($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get_all_sensor_snapshot, request, options: options);
  }

  $grpc.ResponseFuture<$0.Acquisition> is_sensor_acquiring($0.Sensor request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_sensor_acquiring, request, options: options);
  }

  $grpc.ResponseFuture<$1.Acquisitions> is_all_sensor_acquiring($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$is_all_sensor_acquiring, request, options: options);
  }

  $grpc.ResponseFuture<$0.Acquisition> start_sensor_acquisition($0.Sensor request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$start_sensor_acquisition, request, options: options);
  }

  $grpc.ResponseFuture<$1.Acquisitions> start_all_sensor_acquisition($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$start_all_sensor_acquisition, request, options: options);
  }

  $grpc.ResponseFuture<$0.Acquisition> stop_sensor_acquisition($0.Sensor request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$stop_sensor_acquisition, request, options: options);
  }

  $grpc.ResponseFuture<$1.Acquisitions> stop_all_sensor_acquisition($0.void_ request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$stop_all_sensor_acquisition, request, options: options);
  }

  $grpc.ResponseFuture<$0.void_> add_voice_tag($1.VoiceTag request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$add_voice_tag, request, options: options);
  }
}

@$pb.GrpcServiceName('ai.swm.trudy.daq.Gateway')
abstract class GatewayServiceBase extends $grpc.Service {
  $core.String get $name => 'protos.Gateway';

  GatewayServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.void_, $0.void_>(
        'ping',
        ping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($0.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Device, $0.Connection>(
        'is_dev_connected',
        is_dev_connected_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Device.fromBuffer(value),
        ($0.Connection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.void_, $1.Connections>(
        'is_all_dev_connected',
        is_all_dev_connected_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($1.Connections value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Device, $0.Health>(
        'is_dev_healthy',
        is_dev_healthy_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Device.fromBuffer(value),
        ($0.Health value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.void_, $1.Healths>(
        'is_all_dev_healthy',
        is_all_dev_healthy_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($1.Healths value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.void_, $0.Sensors>(
        'get_sensors',
        get_sensors_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($0.Sensors value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Sensor, $0.Connection>(
        'is_sensor_connected',
        is_sensor_connected_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Sensor.fromBuffer(value),
        ($0.Connection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.void_, $1.Connections>(
        'is_all_sensor_connected',
        is_all_sensor_connected_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($1.Connections value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Sensor, $0.Health>(
        'is_sensor_healthy',
        is_sensor_healthy_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Sensor.fromBuffer(value),
        ($0.Health value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.void_, $1.Healths>(
        'is_all_sensor_healthy',
        is_all_sensor_healthy_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($1.Healths value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Sensor, $0.SensorSnapshot>(
        'get_sensor_snapshot',
        get_sensor_snapshot_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Sensor.fromBuffer(value),
        ($0.SensorSnapshot value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.void_, $0.SensorSnapshots>(
        'get_all_sensor_snapshot',
        get_all_sensor_snapshot_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($0.SensorSnapshots value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Sensor, $0.Acquisition>(
        'is_sensor_acquiring',
        is_sensor_acquiring_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Sensor.fromBuffer(value),
        ($0.Acquisition value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.void_, $1.Acquisitions>(
        'is_all_sensor_acquiring',
        is_all_sensor_acquiring_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($1.Acquisitions value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Sensor, $0.Acquisition>(
        'start_sensor_acquisition',
        start_sensor_acquisition_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Sensor.fromBuffer(value),
        ($0.Acquisition value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.void_, $1.Acquisitions>(
        'start_all_sensor_acquisition',
        start_all_sensor_acquisition_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($1.Acquisitions value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Sensor, $0.Acquisition>(
        'stop_sensor_acquisition',
        stop_sensor_acquisition_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Sensor.fromBuffer(value),
        ($0.Acquisition value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.void_, $1.Acquisitions>(
        'stop_all_sensor_acquisition',
        stop_all_sensor_acquisition_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.void_.fromBuffer(value),
        ($1.Acquisitions value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.VoiceTag, $0.void_>(
        'add_voice_tag',
        add_voice_tag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.VoiceTag.fromBuffer(value),
        ($0.void_ value) => value.writeToBuffer()));
  }

  $async.Future<$0.void_> ping_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return ping(call, await request);
  }

  $async.Future<$0.Connection> is_dev_connected_Pre($grpc.ServiceCall call, $async.Future<$1.Device> request) async {
    return is_dev_connected(call, await request);
  }

  $async.Future<$1.Connections> is_all_dev_connected_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return is_all_dev_connected(call, await request);
  }

  $async.Future<$0.Health> is_dev_healthy_Pre($grpc.ServiceCall call, $async.Future<$1.Device> request) async {
    return is_dev_healthy(call, await request);
  }

  $async.Future<$1.Healths> is_all_dev_healthy_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return is_all_dev_healthy(call, await request);
  }

  $async.Future<$0.Sensors> get_sensors_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return get_sensors(call, await request);
  }

  $async.Future<$0.Connection> is_sensor_connected_Pre($grpc.ServiceCall call, $async.Future<$0.Sensor> request) async {
    return is_sensor_connected(call, await request);
  }

  $async.Future<$1.Connections> is_all_sensor_connected_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return is_all_sensor_connected(call, await request);
  }

  $async.Future<$0.Health> is_sensor_healthy_Pre($grpc.ServiceCall call, $async.Future<$0.Sensor> request) async {
    return is_sensor_healthy(call, await request);
  }

  $async.Future<$1.Healths> is_all_sensor_healthy_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return is_all_sensor_healthy(call, await request);
  }

  $async.Future<$0.SensorSnapshot> get_sensor_snapshot_Pre($grpc.ServiceCall call, $async.Future<$0.Sensor> request) async {
    return get_sensor_snapshot(call, await request);
  }

  $async.Future<$0.SensorSnapshots> get_all_sensor_snapshot_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return get_all_sensor_snapshot(call, await request);
  }

  $async.Future<$0.Acquisition> is_sensor_acquiring_Pre($grpc.ServiceCall call, $async.Future<$0.Sensor> request) async {
    return is_sensor_acquiring(call, await request);
  }

  $async.Future<$1.Acquisitions> is_all_sensor_acquiring_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return is_all_sensor_acquiring(call, await request);
  }

  $async.Future<$0.Acquisition> start_sensor_acquisition_Pre($grpc.ServiceCall call, $async.Future<$0.Sensor> request) async {
    return start_sensor_acquisition(call, await request);
  }

  $async.Future<$1.Acquisitions> start_all_sensor_acquisition_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return start_all_sensor_acquisition(call, await request);
  }

  $async.Future<$0.Acquisition> stop_sensor_acquisition_Pre($grpc.ServiceCall call, $async.Future<$0.Sensor> request) async {
    return stop_sensor_acquisition(call, await request);
  }

  $async.Future<$1.Acquisitions> stop_all_sensor_acquisition_Pre($grpc.ServiceCall call, $async.Future<$0.void_> request) async {
    return stop_all_sensor_acquisition(call, await request);
  }

  $async.Future<$0.void_> add_voice_tag_Pre($grpc.ServiceCall call, $async.Future<$1.VoiceTag> request) async {
    return add_voice_tag(call, await request);
  }

  $async.Future<$0.void_> ping($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.Connection> is_dev_connected($grpc.ServiceCall call, $1.Device request);
  $async.Future<$1.Connections> is_all_dev_connected($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.Health> is_dev_healthy($grpc.ServiceCall call, $1.Device request);
  $async.Future<$1.Healths> is_all_dev_healthy($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.Sensors> get_sensors($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.Connection> is_sensor_connected($grpc.ServiceCall call, $0.Sensor request);
  $async.Future<$1.Connections> is_all_sensor_connected($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.Health> is_sensor_healthy($grpc.ServiceCall call, $0.Sensor request);
  $async.Future<$1.Healths> is_all_sensor_healthy($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.SensorSnapshot> get_sensor_snapshot($grpc.ServiceCall call, $0.Sensor request);
  $async.Future<$0.SensorSnapshots> get_all_sensor_snapshot($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.Acquisition> is_sensor_acquiring($grpc.ServiceCall call, $0.Sensor request);
  $async.Future<$1.Acquisitions> is_all_sensor_acquiring($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.Acquisition> start_sensor_acquisition($grpc.ServiceCall call, $0.Sensor request);
  $async.Future<$1.Acquisitions> start_all_sensor_acquisition($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.Acquisition> stop_sensor_acquisition($grpc.ServiceCall call, $0.Sensor request);
  $async.Future<$1.Acquisitions> stop_all_sensor_acquisition($grpc.ServiceCall call, $0.void_ request);
  $async.Future<$0.void_> add_voice_tag($grpc.ServiceCall call, $1.VoiceTag request);
}
