import 'dart:ui';

import 'package:daq_dashboard/src/Configure/configUtil.dart';
import 'package:daq_dashboard/src/Controllers/AcquisitionController.dart';
import 'package:daq_dashboard/src/Controllers/CameraController.dart';
import 'package:daq_dashboard/src/Controllers/ControllerFactory.dart';
import 'package:daq_dashboard/src/Controllers/DaqEdgeController.dart';
import 'package:daq_dashboard/src/Controllers/GnssController.dart';
import 'package:daq_dashboard/src/Controllers/NetController.dart';
import 'package:daq_dashboard/src/Controllers/NetStatusController.dart';
import 'package:daq_dashboard/src/Controllers/NotificationController.dart';
import 'package:daq_dashboard/src/Controllers/PopupController.dart';
import 'package:daq_dashboard/src/Controllers/RecordingController.dart';
import 'package:daq_dashboard/src/Controllers/SSHController.dart';
import 'package:daq_dashboard/src/Controllers/StorageController.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/dtos/ConnectInfoDTO.dart';
import 'package:daq_dashboard/src/dtos/ControllerFactoryDTO.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/Models/DeviceModel.dart';
import 'package:daq_dashboard/src/Models/NetStatusModel.dart';
import 'package:daq_dashboard/src/Models/TraceRouteModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/network/SSHRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/widgets/AcquisitionWidget.dart';
import 'package:daq_dashboard/src/widgets/CameraWidget.dart';
import 'package:daq_dashboard/src/widgets/GnssWidget.dart';
import 'package:daq_dashboard/src/widgets/NetStatusWidget.dart';
import 'package:daq_dashboard/src/widgets/NotificationControllWidget.dart';
import 'package:daq_dashboard/src/widgets/StorageWidget.dart';
import 'package:daq_dashboard/src/widgets/VoiceRecordingWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


// ── AP500L 전용 tag ───────────────────────────────────────────
enum eTags {
  None,

  // 카메라 3대
  cam0,   // /dev/video0  (좌)
  cam1,   // /dev/video1  (중앙)
  cam2,   // /dev/video2  (우)

  // GNSS
  gnss,

  // UI 전용
  netStatus,
  storage,
  popup,
  acquisition,
  notification,
  voice_record,
  daq_edge,

  // trace (네트워크 ping)
  trace_lte,
  trace_wan,
  dev_cpu,
}

enum eWidgetType {
  Camera,
  GNSS,
  NetStatus,
  Storage,
  Acquisition,
  Notification,
  VoiceRecord,
}

enum eWidgetID {
  VoiceRecord,
  VoiceRecordPopup,
}

enum eWidgetStatus {
  Active,
  UnActive
}

enum eNetSnapShapContentType {
  UnKnown,
}

enum eBool {
  Error,
  True,
  False
}

extension eBoolExtension on eBool {
  static const Map<eBool, String> _values = {
    eBool.Error: "error",
    eBool.True: "true",
    eBool.False: "false",
  };

  static eBool fromString(String value) {
    for (var entry in _values.entries) {
      if (entry.value.toLowerCase() == value.toLowerCase()) {
        return entry.key;
      }
    }
    return eBool.Error;
  }

  static bool fromStringToBool(String value) {
    for (var entry in _values.entries) {
      if (entry.value.toLowerCase() == value.toLowerCase()) {
        return entry.key == eBool.True;
      }
    }
    return false;
  }
}

class Defines {

  static const String version = "v_ap500l-1.0.0";

  static const double const_screen_width  = 2960;
  static const double const_screen_height = 1848;

  static Map<String, ConnectInfoDTO> _connectInfoDtos = {
    "ap500l" : ConnectInfoDTO("192.168.20.100", 50050),
    "test"   : ConnectInfoDTO("192.168.1.72",   50050),
  };

  static get getServerNames => Defines._connectInfoDtos.keys.toList();

  static ConnectInfoDTO? getConnectInfo(String _server_name) {
    return Defines._connectInfoDtos[_server_name];
  }

  static Size getScreenSize(double width) {
    return Size(width, Defines.const_screen_height * width / Defines.const_screen_width);
  }

  static Map<String, eNetSnapShapContentType> _ContextTypeMapper = {
    "unknown": eNetSnapShapContentType.UnKnown,
  };

  static bool isSameContextType(String _context_type, eNetSnapShapContentType _eNetSnapShapContentType) {
    if (_ContextTypeMapper.containsKey(_context_type.toLowerCase()))
      return Defines._ContextTypeMapper[_context_type.toLowerCase()] == _eNetSnapShapContentType;
    return false;
  }

  static Map<String, eTags> _PingKeyMapper = {
    "lte" : eTags.trace_lte,
    "wan" : eTags.trace_wan,
    "cpu" : eTags.dev_cpu,
  };

  static eTags? getTagFromPingKey(String key) {
    return Defines._PingKeyMapper[key];
  }

  static String? getConfigKeyFromTagKey(eTags key) {
    for (String config_key in Defines._PingKeyMapper.keys) {
      if (Defines._PingKeyMapper[config_key] == key) {
        return config_key;
      }
    }
    return null;
  }

  // ── sensor name: daq-service 반환값과 정확히 일치시킴 ────────
  static Map<eTags, List<metaProperty>> _metaProperties = {

    eTags.None: [
      // 카메라 3대  →  daq-service SENSOR_NAMES 와 일치
      metaProperty(tag: eTags.cam0, tag_name: "cam0", sensor_name: "cam0", display_name: "CAM 0 (좌)"),
      metaProperty(tag: eTags.cam1, tag_name: "cam1", sensor_name: "cam1", display_name: "CAM 1 (중앙)"),
      metaProperty(tag: eTags.cam2, tag_name: "cam2", sensor_name: "cam2", display_name: "CAM 2 (우)"),

      // GNSS  →  daq-service SENSOR_NAMES 와 일치
      metaProperty(tag: eTags.gnss, tag_name: "gnss", sensor_name: "gnss", display_name: "GNSS"),

      // UI 전용 (gRPC sensor 아님)
      metaProperty(tag: eTags.storage,     tag_name: "cpu/storage",  sensor_name: "cpu/storage",  display_name: "Storage"),
      metaProperty(tag: eTags.notification, tag_name: "notification", sensor_name: "notification", display_name: "Notification"),
      metaProperty(tag: eTags.popup,        tag_name: "popup",        sensor_name: "popup",        display_name: "Popup"),
      metaProperty(tag: eTags.acquisition,  tag_name: "acquisition",  sensor_name: "acquisition",  display_name: "Acquisition"),
      metaProperty(tag: eTags.voice_record, tag_name: "voice_record", sensor_name: "voice_record", display_name: "VoiceRecord"),
      metaProperty(tag: eTags.daq_edge,     tag_name: "daq_edge",     sensor_name: "daq_edge",     display_name: "DAQ Edge"),
    ],

    eTags.netStatus: [
      metaProperty(tag: eTags.netStatus, tag_name: "net_status", sensor_name: "net_status", display_name: "NetStatus"),
      metaProperty(tag: eTags.trace_wan, tag_name: "trace/wan",  sensor_name: "trace/wan",  display_name: "WAN",
          on_model_create_callback: Func1((tag_name) => TraceRouteModel(tag_name))),
      metaProperty(tag: eTags.trace_lte, tag_name: "trace/lte",  sensor_name: "trace/lte",  display_name: "Route",
          on_model_create_callback: Func1((tag_name) => TraceRouteModel(tag_name))),
      metaProperty(tag: eTags.dev_cpu,   tag_name: "dev/cpu",    sensor_name: "cpu",        display_name: "CPU",
          on_model_create_callback: Func1((tag_name) => DeviceModel(tag_name))),
    ],
  };

  static Map<eTags, List<metaProperty>> getMetaProperties() {
    return Defines._metaProperties;
  }

  // ── 위젯 크기 ─────────────────────────────────────────────────
  // 카메라 3대 가로 배치: 각 460w × 259h
  static Size cameraSize    = Size(460.w, 259.h);
  static Size gnssSize      = Size(707.63.w, 704.55.h);
  static Size storageSize   = Size(707.63.w, 393.26.h);
  static Size netstatusSize = Size(370.w, 436.59.h);
  static Size acquisitionSize = Size(707.63.w, 161.7.h);
  static Size flexSize      = Size(0, 0);
  static Offset defaultOffset = Offset(0, 0);

  static double layOutBoarderWidth  = 2.0.w;
  static double layOutBoarderRadius = 10.0.w;

  static Offset _recodingPopupOffset = Offset(2220.w, 1848.h);
  static Size recodingPopupSzie = Size(1600.w, 1400.h);

  static Offset get recodingPopupOffset =>
    Offset(_recodingPopupOffset.dx / 2 - recodingPopupSzie.width / 2,
           _recodingPopupOffset.dy / 2 - recodingPopupSzie.height / 2);

  // ── 위젯 팩토리 ───────────────────────────────────────────────
  static Map<eWidgetType, widgetProperty> _widgetProperties = {
    eWidgetType.Camera      : widgetProperty(eWidgetType.Camera,      defaultOffset, cameraSize,      Func1((etag) => CameraWidget(etag))),
    eWidgetType.GNSS        : widgetProperty(eWidgetType.GNSS,        defaultOffset, gnssSize,        Func1((etag) => GnssWidget(etag))),
    eWidgetType.NetStatus   : widgetProperty(eWidgetType.NetStatus,   defaultOffset, netstatusSize,   Func1((etag) => NetStatusWidget(etag))),
    eWidgetType.Storage     : widgetProperty(eWidgetType.Storage,     defaultOffset, storageSize,     Func1((etag) => StorageWidget(etag))),
    eWidgetType.Acquisition : widgetProperty(eWidgetType.Acquisition, defaultOffset, acquisitionSize, Func1((etag) => AcquisitionWidget(etag))),
    eWidgetType.Notification: widgetProperty(eWidgetType.Notification, defaultOffset, flexSize,       Func1((etag) => NotificationControllWidget(etag))),
  };

  static widgetProperty? getWidgetProperty(eWidgetType ewidget_type) {
    return Defines._widgetProperties[ewidget_type];
  }

  static Map<eTags, Func3<eTags, RpcClientRap<GatewayClient>?, int, ControllerCreateDTO>> ControllerMetaTables() {
    return Map<eTags, Func3<eTags, RpcClientRap<GatewayClient>?, int, ControllerCreateDTO>>();
  }

  // ── Controller 등록 ───────────────────────────────────────────
  static Future<void> ControllerRegister(ConnectInfoDTO connectInfo, var millisec) async {

    Get.put(NotificationController(millisec),
        tag: MetaPropertyManager().getMetaProperty(eTags.notification)!.tag_name);

    Get.put(NetController(connectInfo, millisec));

    RpcClientRap<GatewayClient>? rpcClientRap = Get.find<NetController>().rpcClientRap;
    Get.put(PopupController(rpcClientRap),
        tag: MetaPropertyManager().getMetaProperty(eTags.popup)!.tag_name);

    Get.put(SSHController(connectInfo.daqEdgeDTO, rpcClientRap, millisec));
    SSHRap? sshRap = Get.find<SSHController>().sshRap;

    // Controller 팩토리 등록
    ControllerFactory.registerController<CameraController>(
        (rpcClientRap, millisec, taggingMetaProperty, is_active) async {
          final controller = CameraController(rpcClientRap, millisec, taggingMetaProperty, is_active);
          await controller.initializeAsync();
          return controller;
        });

    ControllerFactory.registerController<NetStatusController>(
        (rpcClientRap, millisec, taggingMetaProperty, is_active) async {
          final controller = NetStatusController(rpcClientRap, millisec, taggingMetaProperty, is_active);
          await controller.initializeAsync();
          return controller;
        });

    ControllerFactory.registerController<GnssController>(
        (rpcClientRap, millisec, taggingMetaProperty, is_active) async {
          final controller = GnssController(rpcClientRap, millisec, taggingMetaProperty, is_active);
          await controller.initializeAsync();
          return controller;
        });

    ControllerFactory.registerController<StorageController>(
        (rpcClientRap, millisec, taggingMetaProperty, is_active) async {
          final controller = StorageController(rpcClientRap, millisec, taggingMetaProperty, is_active);
          await controller.initializeAsync();
          return controller;
        });

    ControllerFactory.registerController<AcquisitionController>(
        (rpcClientRap, millisec, taggingMetaProperty, is_active) async {
          final controller = AcquisitionController(rpcClientRap, millisec, taggingMetaProperty, is_active);
          await controller.initializeAsync();
          return controller;
        });

    ControllerFactory.registerController<RecordingController>(
        (rpcClientRap, millisec, taggingMetaProperty, is_active) async {
          final controller = RecordingController(rpcClientRap, millisec, taggingMetaProperty, is_active);
          await controller.initializeAsync();
          return controller;
        });

    ControllerFactory.registerController<DaqEdgeController>(
        (rpcClientRap, millisec, taggingMetaProperty, is_active) async {
          final controller = DaqEdgeController(rpcClientRap, millisec, taggingMetaProperty, sshRap!, is_active);
          await controller.initializeAsync();
          return controller;
        });

    // 카메라 3대 등록  (cam0=좌, cam1=중앙, cam2=우)
    await Get.putAsync<CameraController>(() async =>
        await ControllerFactory.create<CameraController>(rpcClientRap, millisec,
            MetaPropertyManager().getMetaProperty(eTags.cam0)!, true),
        tag: MetaPropertyManager().getMetaProperty(eTags.cam0)!.tag_name);

    await Get.putAsync<CameraController>(() async =>
        await ControllerFactory.create<CameraController>(rpcClientRap, millisec,
            MetaPropertyManager().getMetaProperty(eTags.cam1)!, true),
        tag: MetaPropertyManager().getMetaProperty(eTags.cam1)!.tag_name);

    await Get.putAsync<CameraController>(() async =>
        await ControllerFactory.create<CameraController>(rpcClientRap, millisec,
            MetaPropertyManager().getMetaProperty(eTags.cam2)!, true),
        tag: MetaPropertyManager().getMetaProperty(eTags.cam2)!.tag_name);

    // NetStatus
    await Get.putAsync<NetStatusController>(() async =>
        await ControllerFactory.create<NetStatusController>(rpcClientRap, millisec,
            MetaPropertyManager().getMetaProperty(eTags.netStatus)!, true),
        tag: MetaPropertyManager().getMetaProperty(eTags.netStatus)!.tag_name);

    // GNSS
    await Get.putAsync<GnssController>(() async =>
        await ControllerFactory.create<GnssController>(rpcClientRap, millisec,
            MetaPropertyManager().getMetaProperty(eTags.gnss)!, true),
        tag: MetaPropertyManager().getMetaProperty(eTags.gnss)!.tag_name);

    // Storage
    await Get.putAsync<StorageController>(() async =>
        await ControllerFactory.create<StorageController>(rpcClientRap, millisec,
            MetaPropertyManager().getMetaProperty(eTags.storage)!, true),
        tag: MetaPropertyManager().getMetaProperty(eTags.storage)!.tag_name);

    // Acquisition (수집 시작/종료)
    await Get.putAsync<AcquisitionController>(() async =>
        await ControllerFactory.create<AcquisitionController>(rpcClientRap, millisec,
            MetaPropertyManager().getMetaProperty(eTags.acquisition)!, true),
        tag: MetaPropertyManager().getMetaProperty(eTags.acquisition)!.tag_name);

    // VoiceRecord
    await Get.putAsync<RecordingController>(() async =>
        await ControllerFactory.create<RecordingController>(rpcClientRap, millisec,
            MetaPropertyManager().getMetaProperty(eTags.voice_record)!, true),
        tag: MetaPropertyManager().getMetaProperty(eTags.voice_record)!.tag_name);

    // DaqEdge
    await Get.putAsync<DaqEdgeController>(() async =>
        await ControllerFactory.create<DaqEdgeController>(rpcClientRap, 2000,
            MetaPropertyManager().getMetaProperty(eTags.daq_edge)!, true),
        tag: MetaPropertyManager().getMetaProperty(eTags.daq_edge)!.tag_name);
  }
}
