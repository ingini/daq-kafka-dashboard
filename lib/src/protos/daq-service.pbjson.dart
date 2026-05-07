//
//  Generated code. Do not modify.
//  source: daq-service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use void_Descriptor instead')
const void_$json = {
  '1': 'void',
};

/// Descriptor for `void`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List void_Descriptor = $convert.base64Decode(
    'CgR2b2lk');

@$core.Deprecated('Use sensorDescriptor instead')
const Sensor$json = {
  '1': 'Sensor',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'ability', '3': 2, '4': 1, '5': 14, '6': '.protos.Sensor.HealthCheck', '9': 0, '10': 'ability', '17': true},
  ],
  '4': [Sensor_HealthCheck$json],
  '8': [
    {'1': '_ability'},
  ],
};

@$core.Deprecated('Use sensorDescriptor instead')
const Sensor_HealthCheck$json = {
  '1': 'HealthCheck',
  '2': [
    {'1': 'ENABLE', '2': 0},
    {'1': 'UNABLE', '2': 1},
  ],
};

/// Descriptor for `Sensor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorDescriptor = $convert.base64Decode(
    'CgZTZW5zb3ISEgoEbmFtZRgBIAEoCVIEbmFtZRI5CgdhYmlsaXR5GAIgASgOMhoucHJvdG9zLl'
    'NlbnNvci5IZWFsdGhDaGVja0gAUgdhYmlsaXR5iAEBIiUKC0hlYWx0aENoZWNrEgoKBkVOQUJM'
    'RRAAEgoKBlVOQUJMRRABQgoKCF9hYmlsaXR5');

@$core.Deprecated('Use sensorsDescriptor instead')
const Sensors$json = {
  '1': 'Sensors',
  '2': [
    {'1': 'list', '3': 1, '4': 3, '5': 9, '10': 'list'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `Sensors`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorsDescriptor = $convert.base64Decode(
    'CgdTZW5zb3JzEhIKBGxpc3QYASADKAlSBGxpc3QSFgoGcmVhc29uGAIgASgJUgZyZWFzb24=');

@$core.Deprecated('Use connectionDescriptor instead')
const Connection$json = {
  '1': 'Connection',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'state', '3': 2, '4': 1, '5': 14, '6': '.protos.Connection.State', '10': 'state'},
  ],
  '4': [Connection_State$json],
};

@$core.Deprecated('Use connectionDescriptor instead')
const Connection_State$json = {
  '1': 'State',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'CONNECTED', '2': 1},
    {'1': 'DISCONNECTED', '2': 2},
  ],
};

/// Descriptor for `Connection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionDescriptor = $convert.base64Decode(
    'CgpDb25uZWN0aW9uEhIKBG5hbWUYASABKAlSBG5hbWUSLgoFc3RhdGUYAiABKA4yGC5wcm90b3'
    'MuQ29ubmVjdGlvbi5TdGF0ZVIFc3RhdGUiNQoFU3RhdGUSCwoHVU5LTk9XThAAEg0KCUNPTk5F'
    'Q1RFRBABEhAKDERJU0NPTk5FQ1RFRBAC');

@$core.Deprecated('Use healthDescriptor instead')
const Health$json = {
  '1': 'Health',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.protos.Health.Status', '10': 'status'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
  '4': [Health_Status$json],
};

@$core.Deprecated('Use healthDescriptor instead')
const Health_Status$json = {
  '1': 'Status',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'GOOD', '2': 1},
    {'1': 'WARN', '2': 2},
    {'1': 'BAAD', '2': 3},
  ],
};

/// Descriptor for `Health`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthDescriptor = $convert.base64Decode(
    'CgZIZWFsdGgSEgoEbmFtZRgBIAEoCVIEbmFtZRItCgZzdGF0dXMYAiABKA4yFS5wcm90b3MuSG'
    'VhbHRoLlN0YXR1c1IGc3RhdHVzEhYKBnJlYXNvbhgDIAEoCVIGcmVhc29uIjMKBlN0YXR1cxIL'
    'CgdVTktOT1dOEAASCAoER09PRBABEggKBFdBUk4QAhIICgRCQUFEEAM=');

@$core.Deprecated('Use sensorSnapshotDescriptor instead')
const SensorSnapshot$json = {
  '1': 'SensorSnapshot',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'content_type', '3': 2, '4': 1, '5': 9, '10': 'contentType'},
    {'1': 'data', '3': 3, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `SensorSnapshot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorSnapshotDescriptor = $convert.base64Decode(
    'Cg5TZW5zb3JTbmFwc2hvdBISCgRuYW1lGAEgASgJUgRuYW1lEiEKDGNvbnRlbnRfdHlwZRgCIA'
    'EoCVILY29udGVudFR5cGUSEgoEZGF0YRgDIAEoDFIEZGF0YQ==');

@$core.Deprecated('Use sensorSnapshotsDescriptor instead')
const SensorSnapshots$json = {
  '1': 'SensorSnapshots',
  '2': [
    {'1': 'list', '3': 1, '4': 3, '5': 11, '6': '.protos.SensorSnapshot', '10': 'list'},
  ],
};

/// Descriptor for `SensorSnapshots`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorSnapshotsDescriptor = $convert.base64Decode(
    'Cg9TZW5zb3JTbmFwc2hvdHMSKgoEbGlzdBgBIAMoCzIWLnByb3Rvcy5TZW5zb3JTbmFwc2hvdF'
    'IEbGlzdA==');

@$core.Deprecated('Use acquisitionDescriptor instead')
const Acquisition$json = {
  '1': 'Acquisition',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'state', '3': 2, '4': 1, '5': 14, '6': '.protos.Acquisition.State', '10': 'state'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
  '4': [Acquisition_State$json],
};

@$core.Deprecated('Use acquisitionDescriptor instead')
const Acquisition_State$json = {
  '1': 'State',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'ACQUIRING', '2': 1},
    {'1': 'NOT_ACQUIRING', '2': 2},
  ],
};

/// Descriptor for `Acquisition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acquisitionDescriptor = $convert.base64Decode(
    'CgtBY3F1aXNpdGlvbhISCgRuYW1lGAEgASgJUgRuYW1lEi8KBXN0YXRlGAIgASgOMhkucHJvdG'
    '9zLkFjcXVpc2l0aW9uLlN0YXRlUgVzdGF0ZRIWCgZyZWFzb24YAyABKAlSBnJlYXNvbiI2CgVT'
    'dGF0ZRILCgdVTktOT1dOEAASDQoJQUNRVUlSSU5HEAESEQoNTk9UX0FDUVVJUklORxAC');

