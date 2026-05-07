//
//  Generated code. Do not modify.
//  source: daq-gateway.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use deviceDescriptor instead')
const Device$json = {
  '1': 'Device',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `Device`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceDescriptor = $convert.base64Decode(
    'CgZEZXZpY2USEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use connectionsDescriptor instead')
const Connections$json = {
  '1': 'Connections',
  '2': [
    {'1': 'list', '3': 1, '4': 3, '5': 11, '6': '.protos.Connection', '10': 'list'},
  ],
};

/// Descriptor for `Connections`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionsDescriptor = $convert.base64Decode(
    'CgtDb25uZWN0aW9ucxImCgRsaXN0GAEgAygLMhIucHJvdG9zLkNvbm5lY3Rpb25SBGxpc3Q=');

@$core.Deprecated('Use healthsDescriptor instead')
const Healths$json = {
  '1': 'Healths',
  '2': [
    {'1': 'list', '3': 1, '4': 3, '5': 11, '6': '.protos.Health', '10': 'list'},
  ],
};

/// Descriptor for `Healths`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthsDescriptor = $convert.base64Decode(
    'CgdIZWFsdGhzEiIKBGxpc3QYASADKAsyDi5wcm90b3MuSGVhbHRoUgRsaXN0');

@$core.Deprecated('Use acquisitionsDescriptor instead')
const Acquisitions$json = {
  '1': 'Acquisitions',
  '2': [
    {'1': 'list', '3': 1, '4': 3, '5': 11, '6': '.protos.Acquisition', '10': 'list'},
  ],
};

/// Descriptor for `Acquisitions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acquisitionsDescriptor = $convert.base64Decode(
    'CgxBY3F1aXNpdGlvbnMSJwoEbGlzdBgBIAMoCzITLnByb3Rvcy5BY3F1aXNpdGlvblIEbGlzdA'
    '==');

@$core.Deprecated('Use voiceTagDescriptor instead')
const VoiceTag$json = {
  '1': 'VoiceTag',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 3, '10': 'timestamp'},
    {'1': 'voice', '3': 2, '4': 1, '5': 12, '10': 'voice'},
  ],
};

/// Descriptor for `VoiceTag`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List voiceTagDescriptor = $convert.base64Decode(
    'CghWb2ljZVRhZxIcCgl0aW1lc3RhbXAYASABKANSCXRpbWVzdGFtcBIUCgV2b2ljZRgCIAEoDF'
    'IFdm9pY2U=');

