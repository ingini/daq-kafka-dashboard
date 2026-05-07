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

import 'daq-service.pbenum.dart';

export 'daq-service.pbenum.dart';

class void_ extends $pb.GeneratedMessage {
  factory void_() => create();
  void_._() : super();
  factory void_.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory void_.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'void', package: const $pb.PackageName(_omitMessageNames ? '' : 'protos'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  void_ clone() => void_()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  void_ copyWith(void Function(void_) updates) => super.copyWith((message) => updates(message as void_)) as void_;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static void_ create() => void_._();
  void_ createEmptyInstance() => create();
  static $pb.PbList<void_> createRepeated() => $pb.PbList<void_>();
  @$core.pragma('dart2js:noInline')
  static void_ getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<void_>(create);
  static void_? _defaultInstance;
}

class Sensor extends $pb.GeneratedMessage {
  factory Sensor({
    $core.String? name,
    Sensor_HealthCheck? ability,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (ability != null) {
      $result.ability = ability;
    }
    return $result;
  }
  Sensor._() : super();
  factory Sensor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Sensor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Sensor', package: const $pb.PackageName(_omitMessageNames ? '' : 'protos'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<Sensor_HealthCheck>(2, _omitFieldNames ? '' : 'ability', $pb.PbFieldType.OE, defaultOrMaker: Sensor_HealthCheck.ENABLE, valueOf: Sensor_HealthCheck.valueOf, enumValues: Sensor_HealthCheck.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Sensor clone() => Sensor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Sensor copyWith(void Function(Sensor) updates) => super.copyWith((message) => updates(message as Sensor)) as Sensor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Sensor create() => Sensor._();
  Sensor createEmptyInstance() => create();
  static $pb.PbList<Sensor> createRepeated() => $pb.PbList<Sensor>();
  @$core.pragma('dart2js:noInline')
  static Sensor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Sensor>(create);
  static Sensor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  /// Sensor 메세지가 파라미터로 사용될 경우 ability는 사용하지 않음
  @$pb.TagNumber(2)
  Sensor_HealthCheck get ability => $_getN(1);
  @$pb.TagNumber(2)
  set ability(Sensor_HealthCheck v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAbility() => $_has(1);
  @$pb.TagNumber(2)
  void clearAbility() => clearField(2);
}

class Sensors extends $pb.GeneratedMessage {
  factory Sensors({
    $core.Iterable<$core.String>? list,
    $core.String? reason,
  }) {
    final $result = create();
    if (list != null) {
      $result.list.addAll(list);
    }
    if (reason != null) {
      $result.reason = reason;
    }
    return $result;
  }
  Sensors._() : super();
  factory Sensors.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Sensors.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Sensors', package: const $pb.PackageName(_omitMessageNames ? '' : 'protos'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'list')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Sensors clone() => Sensors()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Sensors copyWith(void Function(Sensors) updates) => super.copyWith((message) => updates(message as Sensors)) as Sensors;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Sensors create() => Sensors._();
  Sensors createEmptyInstance() => create();
  static $pb.PbList<Sensors> createRepeated() => $pb.PbList<Sensors>();
  @$core.pragma('dart2js:noInline')
  static Sensors getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Sensors>(create);
  static Sensors? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get list => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class Connection extends $pb.GeneratedMessage {
  factory Connection({
    $core.String? name,
    Connection_State? state,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (state != null) {
      $result.state = state;
    }
    return $result;
  }
  Connection._() : super();
  factory Connection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Connection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Connection', package: const $pb.PackageName(_omitMessageNames ? '' : 'protos'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<Connection_State>(2, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: Connection_State.UNKNOWN, valueOf: Connection_State.valueOf, enumValues: Connection_State.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Connection clone() => Connection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Connection copyWith(void Function(Connection) updates) => super.copyWith((message) => updates(message as Connection)) as Connection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Connection create() => Connection._();
  Connection createEmptyInstance() => create();
  static $pb.PbList<Connection> createRepeated() => $pb.PbList<Connection>();
  @$core.pragma('dart2js:noInline')
  static Connection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Connection>(create);
  static Connection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  Connection_State get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(Connection_State v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);
}

class Health extends $pb.GeneratedMessage {
  factory Health({
    $core.String? name,
    Health_Status? status,
    $core.String? reason,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (status != null) {
      $result.status = status;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    return $result;
  }
  Health._() : super();
  factory Health.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Health.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Health', package: const $pb.PackageName(_omitMessageNames ? '' : 'protos'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<Health_Status>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: Health_Status.UNKNOWN, valueOf: Health_Status.valueOf, enumValues: Health_Status.values)
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Health clone() => Health()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Health copyWith(void Function(Health) updates) => super.copyWith((message) => updates(message as Health)) as Health;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Health create() => Health._();
  Health createEmptyInstance() => create();
  static $pb.PbList<Health> createRepeated() => $pb.PbList<Health>();
  @$core.pragma('dart2js:noInline')
  static Health getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Health>(create);
  static Health? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  Health_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(Health_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);
}

class SensorSnapshot extends $pb.GeneratedMessage {
  factory SensorSnapshot({
    $core.String? name,
    $core.String? contentType,
    $core.List<$core.int>? data,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (contentType != null) {
      $result.contentType = contentType;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  SensorSnapshot._() : super();
  factory SensorSnapshot.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SensorSnapshot.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SensorSnapshot', package: const $pb.PackageName(_omitMessageNames ? '' : 'protos'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'contentType')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SensorSnapshot clone() => SensorSnapshot()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SensorSnapshot copyWith(void Function(SensorSnapshot) updates) => super.copyWith((message) => updates(message as SensorSnapshot)) as SensorSnapshot;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SensorSnapshot create() => SensorSnapshot._();
  SensorSnapshot createEmptyInstance() => create();
  static $pb.PbList<SensorSnapshot> createRepeated() => $pb.PbList<SensorSnapshot>();
  @$core.pragma('dart2js:noInline')
  static SensorSnapshot getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SensorSnapshot>(create);
  static SensorSnapshot? _defaultInstance;

  /// 센서 이름
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  /// 컨텐츠 타입: image/jpeg
  @$pb.TagNumber(2)
  $core.String get contentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set contentType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearContentType() => clearField(2);

  /// 데이터
  @$pb.TagNumber(3)
  $core.List<$core.int> get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
}

class SensorSnapshots extends $pb.GeneratedMessage {
  factory SensorSnapshots({
    $core.Iterable<SensorSnapshot>? list,
  }) {
    final $result = create();
    if (list != null) {
      $result.list.addAll(list);
    }
    return $result;
  }
  SensorSnapshots._() : super();
  factory SensorSnapshots.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SensorSnapshots.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SensorSnapshots', package: const $pb.PackageName(_omitMessageNames ? '' : 'protos'), createEmptyInstance: create)
    ..pc<SensorSnapshot>(1, _omitFieldNames ? '' : 'list', $pb.PbFieldType.PM, subBuilder: SensorSnapshot.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SensorSnapshots clone() => SensorSnapshots()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SensorSnapshots copyWith(void Function(SensorSnapshots) updates) => super.copyWith((message) => updates(message as SensorSnapshots)) as SensorSnapshots;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SensorSnapshots create() => SensorSnapshots._();
  SensorSnapshots createEmptyInstance() => create();
  static $pb.PbList<SensorSnapshots> createRepeated() => $pb.PbList<SensorSnapshots>();
  @$core.pragma('dart2js:noInline')
  static SensorSnapshots getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SensorSnapshots>(create);
  static SensorSnapshots? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SensorSnapshot> get list => $_getList(0);
}

class Acquisition extends $pb.GeneratedMessage {
  factory Acquisition({
    $core.String? name,
    Acquisition_State? state,
    $core.String? reason,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (state != null) {
      $result.state = state;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    return $result;
  }
  Acquisition._() : super();
  factory Acquisition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Acquisition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Acquisition', package: const $pb.PackageName(_omitMessageNames ? '' : 'protos'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<Acquisition_State>(2, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: Acquisition_State.UNKNOWN, valueOf: Acquisition_State.valueOf, enumValues: Acquisition_State.values)
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Acquisition clone() => Acquisition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Acquisition copyWith(void Function(Acquisition) updates) => super.copyWith((message) => updates(message as Acquisition)) as Acquisition;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Acquisition create() => Acquisition._();
  Acquisition createEmptyInstance() => create();
  static $pb.PbList<Acquisition> createRepeated() => $pb.PbList<Acquisition>();
  @$core.pragma('dart2js:noInline')
  static Acquisition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Acquisition>(create);
  static Acquisition? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  Acquisition_State get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(Acquisition_State v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
