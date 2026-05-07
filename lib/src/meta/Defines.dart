import 'dart:ui';

import 'package:daq_dashboard/src/Configure/configUtil.dart';
import 'package:daq_dashboard/src/Controllers/AcquisitionController.dart';
import 'package:daq_dashboard/src/Controllers/CameraController.dart';
import 'package:daq_dashboard/src/Controllers/CanController.dart';
import 'package:daq_dashboard/src/Controllers/ControllerFactory.dart';
import 'package:daq_dashboard/src/Controllers/DaqEdgeController.dart';
import 'package:daq_dashboard/src/Controllers/GnssController.dart';
import 'package:daq_dashboard/src/Controllers/IntegrationLidarController.dart';
import 'package:daq_dashboard/src/Controllers/LidarController.dart';
import 'package:daq_dashboard/src/Controllers/NetController.dart';
import 'package:daq_dashboard/src/Controllers/NetStatusController.dart';
import 'package:daq_dashboard/src/Controllers/NotificationController.dart';
import 'package:daq_dashboard/src/Controllers/PopupController.dart';
import 'package:daq_dashboard/src/Controllers/RecordingController.dart';
import 'package:daq_dashboard/src/Controllers/SSHController.dart';
import 'package:daq_dashboard/src/Controllers/StorageController.dart';
import 'package:daq_dashboard/src/Controllers/TraceRouteController.dart';
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
import 'package:daq_dashboard/src/widgets/CanWidget.dart';
import 'package:daq_dashboard/src/widgets/GnssWidget.dart';
import 'package:daq_dashboard/src/widgets/IntergrationLidarWidget.dart';
import 'package:daq_dashboard/src/widgets/LidarEachWidget.dart';
import 'package:daq_dashboard/src/widgets/LidarWidget.dart';
import 'package:daq_dashboard/src/widgets/NetStatusWidget.dart';
import 'package:daq_dashboard/src/widgets/NotificationControllWidget.dart';
import 'package:daq_dashboard/src/widgets/RearCameraWidget.dart';
import 'package:daq_dashboard/src/widgets/StorageWidget.dart';
import 'package:daq_dashboard/src/widgets/VoiceRecordingWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


enum eTags {

  None,

  cam_a_1,
  cam_a_2,
  cam_b_1,
  cam_b_2,
  cam_b_3,
  cam_b_4,
  cam_c_1,
  cam_c_2,
  cam_c_3,
  cam_c_4,
  lidar,

  can ,

  netStatus ,

  lidar_eth_e_a,
  lidar_eth_e_b,
  lidar_eth_e_c,
  lidar_eth_e_d,
  lidar_eth_e_i,
  lidar_eth_e_j,
  lidar_eth_e_k,
  lidar_eth_e_l,
  lidar_eth_e_e,

  trace_lte,
  trace_wan,

  dev_cpu,
  dev_vpu_a,
  dev_vpu_b,
  dev_vpu_c,
  gnss,
  storage,
  popup,
  acquisition,

  notification,

  voice_record,

  daq_edge,
}

enum eWidgetType {
  Camera,
  RearCamera,
  Lidar,
  Can,
  NetStatus,
  IntergrationLidar,
  Trace,
  Device,
  GNSS,
  Storage,

  Acquisition,
  Notification,

  VoiceRecord,
}

enum eWidgetID {
  VoiceRecord,
  VoiceRecordPopup,
}



enum eLidarType {
  AT128,
  RSBP
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

  static const String version = "v_20260427-1";

  static const double const_screen_width = 2960;
  static const double const_screen_height = 1848;



  static  Map<String , ConnectInfoDTO> _connectInfoDtos = {
    "test" : ConnectInfoDTO("192.168.1.72" , 50050) ,
    "ap500" : ConnectInfoDTO("192.168.20.100" , 50050)
  };

  static get getServerNames =>  Defines._connectInfoDtos.keys.toList();

  static ConnectInfoDTO? getConnectInfo( String _server_name ) {
    return Defines._connectInfoDtos[_server_name];
  }

  static Size getScreenSize( double width ) {

    // double ratio = width / Defines.const_screen_width;
    return Size(width , Defines.const_screen_height * width / Defines.const_screen_width);

  }

  static Map< String , eNetSnapShapContentType > _ContextTypeMapper = {
    "unkonwn" : eNetSnapShapContentType.UnKnown,
  } ;

  static bool isSameContextType(String _context_type  , eNetSnapShapContentType _eNetSnapShapContentType ) {

    if( _ContextTypeMapper.containsKey(_context_type.toLowerCase()) )
      return Defines._ContextTypeMapper[_context_type.toLowerCase()] == _eNetSnapShapContentType;

    return false;
  }





  static Map< String , eTags > _PingKeyMapper = {
    "lte" : eTags.trace_lte,
    "wan" : eTags.trace_wan,
    "cpu" : eTags.dev_cpu,
  } ;

  static eTags? getTagFromPingKey( String key ) {
    return Defines._PingKeyMapper[key];
  }

  static String? getConfigKeyFromTagKey( eTags key ) {

    for( String config_key in Defines._PingKeyMapper.keys ) {
      if( Defines._PingKeyMapper[config_key] == key ) {
        return config_key;
      }
    }

    return null;
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////

  static const  int Infinity = -1;

  ////////////////////////////////////////////////////////////////////////////////////////////////


  static  Map<eTags , List<metaProperty>> _metaProperties = {

  // eTags.None :[
  //
  //               metaProperty( tag:eTags.cam_a_1 , tag_name:"vpu_a/cam_a_1",  sensor_name:"vpu_a/cam_a_1", sensor_health_name:"cpu/cam_a_1", display_name:"cam_a_1" ),
  //               metaProperty( tag:eTags.cam_a_2 , tag_name:"vpu_a/cam_a_2",  sensor_name:"vpu_a/cam_a_2", sensor_health_name:"cpu/cam_a_2", display_name:"cam_a_2"  ),
  //
  //               metaProperty( tag:eTags.cam_b_1 , tag_name:"cam2", sensor_name:"cam2", sensor_health_name:"cam2", display_name:"cam2" ),
  //               metaProperty( tag:eTags.cam_b_2 , tag_name:"vpu_b/cam_b_2",  sensor_name:"vpu_b/cam_b_2", sensor_health_name:"cpu/cam_b_2", display_name:"cam_b_2" ),
  //               metaProperty( tag:eTags.cam_b_3 , tag_name:"vpu_b/cam_b_3",  sensor_name:"vpu_b/cam_b_3", sensor_health_name:"cpu/cam_b_3", display_name:"cam_b_3" ),
  //               metaProperty( tag:eTags.cam_b_4 , tag_name:"vpu_b/cam_b_4",  sensor_name:"vpu_b/cam_b_4", sensor_health_name:"cpu/cam_b_4", display_name:"cam_b_4" ),
  //               metaProperty( tag:eTags.cam_c_1 , tag_name:"vpu_c/cam_c_1",  sensor_name:"vpu_c/cam_c_1", sensor_health_name:"cpu/cam_c_1", display_name:"cam_c_1" ),
  //               metaProperty( tag:eTags.cam_c_2 , tag_name:"vpu_c/cam_c_2",  sensor_name:"vpu_c/cam_c_2", sensor_health_name:"cpu/cam_c_2", display_name:"cam_c_2" ),
  //               metaProperty( tag:eTags.cam_c_3 , tag_name:"vpu_c/cam_c_3",  sensor_name:"vpu_c/cam_c_3", sensor_health_name:"cpu/cam_c_3", display_name:"cam_c_3" ),
  //               metaProperty( tag:eTags.cam_c_4 , tag_name:"vpu_c/cam_c_4",  sensor_name:"vpu_c/cam_c_4", sensor_health_name:"cpu/cam_c_4", display_name:"cam_c_4" ),
  //
  //               metaProperty( tag:eTags.can , tag_name:"cpu/can",  sensor_name:"cpu/can",  display_name:"can" ),
  //
  //               metaProperty( tag:eTags.gnss ,    tag_name:"cpu/imu",      sensor_name:"cpu/imu",      display_name:"imu" ),
  //               metaProperty( tag:eTags.storage , tag_name:"cpu/storage",  sensor_name:"cpu/storage",  display_name:"storage" ),
  //
  //               metaProperty( tag:eTags.lidar ,         tag_name:"cpu/lidar",    sensor_name:"cpu/lidar",   display_name:"lidar" ),
  //               metaProperty( tag:eTags.lidar_eth_e_a , tag_name:"cpu/eth_e_a" , sensor_name:"cpu/eth_e_a" ,display_name:"eth_e_a" ),
  //               metaProperty( tag:eTags.lidar_eth_e_b , tag_name:"cpu/eth_e_b" , sensor_name:"cpu/eth_e_b" ,display_name:"eth_e_b" ),
  //               metaProperty( tag:eTags.lidar_eth_e_c , tag_name:"cpu/eth_e_c" , sensor_name:"cpu/eth_e_c" ,display_name:"eth_e_c" ),
  //               metaProperty( tag:eTags.lidar_eth_e_d , tag_name:"cpu/eth_e_d" , sensor_name:"cpu/eth_e_d" ,display_name:"eth_e_d" ),
  //               metaProperty( tag:eTags.lidar_eth_e_i , tag_name:"cpu/eth_e_i" , sensor_name:"cpu/eth_e_i" ,display_name:"eth_e_i" ),
  //               metaProperty( tag:eTags.lidar_eth_e_j , tag_name:"cpu/eth_e_j" , sensor_name:"cpu/eth_e_j" ,display_name:"eth_e_j" ),
  //               metaProperty( tag:eTags.lidar_eth_e_k , tag_name:"cpu/eth_e_k" , sensor_name:"cpu/eth_e_k" ,display_name:"eth_e_k" ),
  //               metaProperty( tag:eTags.lidar_eth_e_l , tag_name:"cpu/eth_e_l" , sensor_name:"cpu/eth_e_l" ,display_name:"eth_e_l" ),
  //
  //
  //               metaProperty( tag:eTags.notification , tag_name:"notification" , sensor_name:"notification" ,display_name:"notification" ),
  //
  //               metaProperty( tag:eTags.popup , tag_name:"popup" , sensor_name:"popup" ,display_name:"popup" ),
  //
  //               metaProperty( tag:eTags.acquisition , tag_name:"acquisition" , sensor_name:"acquisition" ,display_name:"acquisition" ),
  //               metaProperty( tag:eTags.voice_record , tag_name:"voice_record" , sensor_name:"voice_record" ,display_name:"voice_record" ),
  //
  //               metaProperty( tag:eTags.daq_edge , tag_name:"daq_edge" , sensor_name:"daq_edge" ,display_name:"daq_edge" ),
  // ],
  //

    eTags.None :[
      // TELE CHIPS
      metaProperty( tag:eTags.cam_a_1 , tag_name:"cam0", sensor_name:"cam0", sensor_health_name:"cam0", display_name:"cam0" ),
      metaProperty( tag:eTags.cam_a_2 , tag_name:"cam1", sensor_name:"cam1", sensor_health_name:"cam1", display_name:"cam1" ),

      // metaProperty( tag:eTags.cam_a_1 , tag_name:"vpu_a/cam_a_1",  sensor_name:"vpu_a/cam_a_1", sensor_health_name:"cpu/cam_a_1", display_name:"cam_a_1" ),
      // metaProperty( tag:eTags.cam_a_2 , tag_name:"vpu_a/cam_a_2",  sensor_name:"vpu_a/cam_a_2", sensor_health_name:"cpu/cam_a_2", display_name:"cam_a_2"  ),

      metaProperty( tag:eTags.cam_b_1 , tag_name:"cam2", sensor_name:"cam2", sensor_health_name:"cam2", display_name:"cam2" ),
      metaProperty( tag:eTags.cam_b_2 , tag_name:"vpu_b/cam_b_2",  sensor_name:"vpu_b/cam_b_2", sensor_health_name:"cpu/cam_b_2", display_name:"cam_b_2" ),
      metaProperty( tag:eTags.cam_b_3 , tag_name:"vpu_b/cam_b_3",  sensor_name:"vpu_b/cam_b_3", sensor_health_name:"cpu/cam_b_3", display_name:"cam_b_3" ),
      metaProperty( tag:eTags.cam_b_4 , tag_name:"vpu_b/cam_b_4",  sensor_name:"vpu_b/cam_b_4", sensor_health_name:"cpu/cam_b_4", display_name:"cam_b_4" ),
      metaProperty( tag:eTags.cam_c_1 , tag_name:"vpu_c/cam_c_1",  sensor_name:"vpu_c/cam_c_1", sensor_health_name:"cpu/cam_c_1", display_name:"cam_c_1" ),
      metaProperty( tag:eTags.cam_c_2 , tag_name:"vpu_c/cam_c_2",  sensor_name:"vpu_c/cam_c_2", sensor_health_name:"cpu/cam_c_2", display_name:"cam_c_2" ),
      metaProperty( tag:eTags.cam_c_3 , tag_name:"vpu_c/cam_c_3",  sensor_name:"vpu_c/cam_c_3", sensor_health_name:"cpu/cam_c_3", display_name:"cam_c_3" ),
      metaProperty( tag:eTags.cam_c_4 , tag_name:"vpu_c/cam_c_4",  sensor_name:"vpu_c/cam_c_4", sensor_health_name:"cpu/cam_c_4", display_name:"cam_c_4" ),

      metaProperty( tag:eTags.can , tag_name:"cpu/can", sensor_name:"cpu/can", display_name:"can" ),

      metaProperty( tag:eTags.gnss , tag_name:"gnss", sensor_name:"gnss", display_name:"gnss" ),
      metaProperty( tag:eTags.storage , tag_name:"cpu/storage", sensor_name:"cpu/storage", display_name:"storage" ),

      // TELE CHIPS
      metaProperty( tag:eTags.lidar , tag_name:"cpu/lidar", sensor_name:"cpu/lidar", display_name:"lidar" ),
      metaProperty( tag:eTags.lidar_eth_e_a , tag_name:"cpu/eth_e_a", sensor_name:"cpu/eth_e_a", display_name:"eth_e_a" ),
      metaProperty( tag:eTags.lidar_eth_e_e , tag_name:"cpu/eth_e_e", sensor_name:"cpu/eth_e_e", display_name:"eth_e_e" ),

      // metaProperty( tag:eTags.lidar ,         tag_name:"cpu/lidar",    sensor_name:"cpu/lidar",   display_name:"lidar" ),
      // metaProperty( tag:eTags.lidar_eth_e_a , tag_name:"cpu/eth_e_a" , sensor_name:"cpu/eth_e_a" ,display_name:"eth_e_a" ),
      // metaProperty( tag:eTags.lidar_eth_e_b , tag_name:"cpu/eth_e_b" , sensor_name:"cpu/eth_e_b" ,display_name:"eth_e_b" ),


      metaProperty( tag:eTags.lidar_eth_e_c , tag_name:"cpu/eth_e_c" , sensor_name:"cpu/eth_e_c" ,display_name:"eth_e_c" ),
      metaProperty( tag:eTags.lidar_eth_e_d , tag_name:"cpu/eth_e_d" , sensor_name:"cpu/eth_e_d" ,display_name:"eth_e_d" ),
      metaProperty( tag:eTags.lidar_eth_e_i , tag_name:"cpu/eth_e_i" , sensor_name:"cpu/eth_e_i" ,display_name:"eth_e_i" ),
      metaProperty( tag:eTags.lidar_eth_e_j , tag_name:"cpu/eth_e_j" , sensor_name:"cpu/eth_e_j" ,display_name:"eth_e_j" ),
      metaProperty( tag:eTags.lidar_eth_e_k , tag_name:"cpu/eth_e_k" , sensor_name:"cpu/eth_e_k" ,display_name:"eth_e_k" ),
      metaProperty( tag:eTags.lidar_eth_e_l , tag_name:"cpu/eth_e_l" , sensor_name:"cpu/eth_e_l" ,display_name:"eth_e_l" ),


      metaProperty( tag:eTags.notification , tag_name:"notification" , sensor_name:"notification" ,display_name:"notification" ),

      metaProperty( tag:eTags.popup , tag_name:"popup" , sensor_name:"popup" ,display_name:"popup" ),

      metaProperty( tag:eTags.acquisition , tag_name:"acquisition" , sensor_name:"acquisition" ,display_name:"acquisition" ),
      metaProperty( tag:eTags.voice_record , tag_name:"voice_record" , sensor_name:"voice_record" ,display_name:"voice_record" ),

      metaProperty( tag:eTags.daq_edge , tag_name:"daq_edge" , sensor_name:"daq_edge" ,display_name:"daq_edge" ),
    ],

    eTags.netStatus : [
                metaProperty( tag:eTags.netStatus , tag_name:"net_status", sensor_name:"net_status",  display_name:"NetStatus"  ),
                metaProperty( tag:eTags.trace_wan , tag_name:"trace/wan",  sensor_name:"trace/wan",   display_name:"WAN" ,    on_model_create_callback:Func1( ( tag_name) => TraceRouteModel(tag_name) ) ),
                metaProperty( tag:eTags.trace_lte , tag_name:"trace/lte",  sensor_name:"trace/lte",   display_name:"Route" ,  on_model_create_callback:Func1( ( tag_name) => TraceRouteModel(tag_name) ) ),

                metaProperty( tag:eTags.dev_cpu , tag_name:"dev/cpu", sensor_name:"cpu", display_name:"CPU", on_model_create_callback:Func1( ( tag_name) => DeviceModel(tag_name) ) ),
    ],

  };

  static Map<eTags , List<metaProperty>> getMetaProperties() {
    return Defines._metaProperties;
  }

  static Size camearaSize = Size(462.5.w,259.88.h);

  static Size gnssSize = Size(707.63.w,704.55.h);
  // static Size gnssSize = Size(0,0);

  static Size intergrationLidarSize = Size(0,0);
  static Size lidarSize = Size(145.69.w,145.53.h);
  // static Size lidarSize = Size(97,97);
  static Size canSize = Size(305.25.w,436.59.h);

  static Size netstatusSize = Size(370.w,436.59.h);

  static Size storageSize = Size(707.63.w,393.26.h);

  static Size flexSize = Size(0,0);
  static Size acquisitionSize = Size(707.63.w,161.7.h);
  static Offset defaultOffset = Offset(0,0);

  static double layOutBoarderWidth = 2.0.w;
  static double layOutBoarderRadius = 10.0.w;

  static Offset _recodingPopupOffset = Offset(2220.w,1848.h);
  static Size recodingPopupSzie = Size(1600.w,1400.h);

  static Offset get recodingPopupOffset =>
    Offset(_recodingPopupOffset.dx / 2 - recodingPopupSzie.width / 2 , _recodingPopupOffset.dy / 2 - recodingPopupSzie.height / 2);




  static  Map<eWidgetType , widgetProperty  > _widgetProperties = {
    eWidgetType.Camera           : widgetProperty( eWidgetType.Camera        , defaultOffset , camearaSize   , Func1(( etag ) => CameraWidget(etag)) ),
    eWidgetType.RearCamera       : widgetProperty( eWidgetType.RearCamera        , defaultOffset , camearaSize   , Func1(( etag ) => RearCameraWidget(etag)) ),

    eWidgetType.Lidar            : widgetProperty( eWidgetType.Lidar         , defaultOffset , lidarSize     , Func1(( etag ) => LidarWidget(etag))),
    // eWidgetType.IntergrationLidar : widgetProperty( eWidgetType.IntergrationLidar , defaultOffset , Size(97,97)   , Func1(( etag ) => IntergrationLidarWidget(etag))),

    eWidgetType.NetStatus        : widgetProperty( eWidgetType.NetStatus , defaultOffset , netstatusSize     , Func1(( etag ) => NetStatusWidget(etag))),

    eWidgetType.Can              : widgetProperty( eWidgetType.Can             , defaultOffset , canSize     , Func1(( etag ) => CanWidget(etag))),

    eWidgetType.Trace            : widgetProperty( eWidgetType.Trace         , defaultOffset , camearaSize   , Func1(( etag ) => CameraWidget(etag))),
    eWidgetType.Device           : widgetProperty( eWidgetType.Device        , defaultOffset , camearaSize   , Func1(( etag ) => CameraWidget(etag))),
    eWidgetType.GNSS             : widgetProperty( eWidgetType.GNSS          , defaultOffset , gnssSize      , Func1(( etag ) => GnssWidget(etag))),
    eWidgetType.Storage          : widgetProperty( eWidgetType.Storage       , defaultOffset , storageSize   , Func1(( etag ) => StorageWidget(etag))),
    eWidgetType.Acquisition      : widgetProperty( eWidgetType.Acquisition   , defaultOffset , acquisitionSize   , Func1(( etag ) => AcquisitionWidget(etag))),
    eWidgetType.Notification     : widgetProperty( eWidgetType.Notification   , defaultOffset , flexSize   , Func1(( etag ) => NotificationControllWidget(etag))),

    // eWidgetType.VoiceRecord   : widgetProperty( eWidgetType.VoiceRecord   , defaultOffset , flexSize   , Func1(( etag ) => VoiceRecordWidget(etag))),
  };

  static widgetProperty? getWidgetProperty( eWidgetType ewidget_type ) {
    return Defines._widgetProperties[ewidget_type];
  }


  /// lidar 별 라이다 종류와 라이다의 회전 각도 table
  static Map<eTags ,lidarIconProperty > _lidarIconPropertieTable = {
    eTags.lidar_eth_e_a : lidarIconProperty( eTags.lidar_eth_e_a , eLidarType.AT128 , 180 ),
    eTags.lidar_eth_e_i : lidarIconProperty( eTags.lidar_eth_e_i , eLidarType.RSBP , 0 ),

    eTags.lidar_eth_e_d : lidarIconProperty( eTags.lidar_eth_e_d , eLidarType.AT128 , 90 ),
    eTags.lidar_eth_e_l : lidarIconProperty( eTags.lidar_eth_e_l , eLidarType.RSBP , 270 ),
    eTags.lidar_eth_e_e : lidarIconProperty( eTags.lidar_eth_e_e , eLidarType.RSBP , 0 ),

    eTags.lidar_eth_e_c : lidarIconProperty( eTags.lidar_eth_e_c , eLidarType.AT128 , 0 ),
    eTags.lidar_eth_e_k : lidarIconProperty( eTags.lidar_eth_e_k , eLidarType.RSBP , 180 ),

    eTags.lidar_eth_e_b : lidarIconProperty( eTags.lidar_eth_e_b , eLidarType.AT128 , 180 ),
    eTags.lidar_eth_e_j : lidarIconProperty( eTags.lidar_eth_e_j , eLidarType.RSBP , 90 ),
  };

  static Map<eTags ,lidarIconProperty > lidarIconPropertieTable( ) {
    return _lidarIconPropertieTable;
  }

  //////////////////////////////////////////////////////////////////


  static Map<eTags ,Func3<eTags ,RpcClientRap<GatewayClient>? , int , ControllerCreateDTO > > ControllerMetaTables( ) {
    return Map<eTags ,Func3<eTags ,RpcClientRap<GatewayClient>? , int , ControllerCreateDTO > >();
  }




  static Future<void> ControllerRegister(ConnectInfoDTO connectInfo, var millisec) async {

    Get.put( NotificationController(millisec) , tag: MetaPropertyManager().getMetaProperty(eTags.notification)!.tag_name );



    Get.put(NetController(connectInfo , millisec) );

    RpcClientRap<GatewayClient>? rpcClientRap = Get.find<NetController>().rpcClientRap;
    Get.put( PopupController( rpcClientRap ) , tag: MetaPropertyManager().getMetaProperty(eTags.popup)!.tag_name );


    Get.put(SSHController(connectInfo.daqEdgeDTO , rpcClientRap , millisec) );
    SSHRap? sshRap = Get.find<SSHController>().sshRap;



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

    ControllerFactory.registerController<CanController>(
            (rpcClientRap, millisec, taggingMetaProperty, is_active) async {
              final controller = CanController(rpcClientRap, millisec, taggingMetaProperty, is_active);
              await controller.initializeAsync();
              return controller;
        });

    ControllerFactory.registerController<IntegrationLidarController>(
            (rpcClientRap, millisec, taggingMetaProperty, is_active) async {
              final controller = IntegrationLidarController(rpcClientRap, millisec, taggingMetaProperty, is_active);
              await controller.initializeAsync();
              return controller;
        });

    ControllerFactory.registerController<LidarController>(
            (rpcClientRap, millisec, taggingMetaProperty, is_active) async {
              final controller = LidarController(rpcClientRap, millisec, taggingMetaProperty, is_active);
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
            (rpcClientRap, millisec, taggingMetaProperty,  is_active) async {
          final controller = DaqEdgeController(rpcClientRap, millisec, taggingMetaProperty , sshRap! , is_active);
          await controller.initializeAsync();
          return controller;
        });

    // TODO : CODE 1
    await Get.putAsync<CameraController>( () async => await ControllerFactory.create<CameraController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.cam_a_1)!, true, ) , tag: MetaPropertyManager().getMetaProperty(eTags.cam_a_1)!.tag_name );
    await Get.putAsync<CameraController>( () async => await ControllerFactory.create<CameraController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.cam_a_2)!, true, ) , tag: MetaPropertyManager().getMetaProperty(eTags.cam_a_2)!.tag_name );
    await Get.putAsync<CameraController>( () async => await ControllerFactory.create<CameraController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.cam_b_1)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.cam_b_1)!.tag_name );
    await Get.putAsync<CameraController>( () async => await ControllerFactory.create<CameraController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.cam_b_2)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.cam_b_2)!.tag_name );
    await Get.putAsync<CameraController>( () async => await ControllerFactory.create<CameraController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.cam_b_3)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.cam_b_3)!.tag_name );
    await Get.putAsync<CameraController>( () async => await ControllerFactory.create<CameraController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.cam_b_4)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.cam_b_4)!.tag_name );
    await Get.putAsync<CameraController>( () async => await ControllerFactory.create<CameraController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.cam_c_1)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.cam_c_1)!.tag_name );
    await Get.putAsync<CameraController>( () async => await ControllerFactory.create<CameraController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.cam_c_2)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.cam_c_2)!.tag_name );
    await Get.putAsync<CameraController>( () async => await ControllerFactory.create<CameraController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.cam_c_3)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.cam_c_3)!.tag_name );
    await Get.putAsync<CameraController>( () async => await ControllerFactory.create<CameraController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.cam_c_4)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.cam_c_4)!.tag_name );


    await Get.putAsync<NetStatusController>( () async => await ControllerFactory.create<NetStatusController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.netStatus)!, true, ) , tag: MetaPropertyManager().getMetaProperty(eTags.netStatus)!.tag_name );

    await Get.putAsync<CanController>( () async => await ControllerFactory.create<CanController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.can)!, true, ) , tag: MetaPropertyManager().getMetaProperty(eTags.can)!.tag_name );

    await Get.putAsync<IntegrationLidarController>( () async => await ControllerFactory.create<IntegrationLidarController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.lidar)!, true, ) , tag: MetaPropertyManager().getMetaProperty(eTags.lidar)!.tag_name );

    await Get.putAsync<LidarController>( () async => await ControllerFactory.create<LidarController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_a)!, true, ) , tag: MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_a)!.tag_name );
    await Get.putAsync<LidarController>( () async => await ControllerFactory.create<LidarController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_e)!, true, ) , tag: MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_e)!.tag_name );
    await Get.putAsync<LidarController>( () async => await ControllerFactory.create<LidarController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_c)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_c)!.tag_name );
    await Get.putAsync<LidarController>( () async => await ControllerFactory.create<LidarController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_d)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_d)!.tag_name );
    await Get.putAsync<LidarController>( () async => await ControllerFactory.create<LidarController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_i)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_i)!.tag_name );
    await Get.putAsync<LidarController>( () async => await ControllerFactory.create<LidarController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_j)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_j)!.tag_name );
    await Get.putAsync<LidarController>( () async => await ControllerFactory.create<LidarController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_k)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_k)!.tag_name );
    await Get.putAsync<LidarController>( () async => await ControllerFactory.create<LidarController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_l)!, false, ) , tag: MetaPropertyManager().getMetaProperty(eTags.lidar_eth_e_l)!.tag_name );

    await Get.putAsync<GnssController>( () async => await ControllerFactory.create<GnssController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.gnss)!, true, ) , tag: MetaPropertyManager().getMetaProperty(eTags.gnss)!.tag_name );

    await Get.putAsync<StorageController>( () async => await ControllerFactory.create<StorageController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.storage)!, true, ) , tag: MetaPropertyManager().getMetaProperty(eTags.storage)!.tag_name );
    await Get.putAsync<AcquisitionController>( () async => await ControllerFactory.create<AcquisitionController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.acquisition)!, true, ) , tag: MetaPropertyManager().getMetaProperty(eTags.acquisition)!.tag_name );
    await Get.putAsync<RecordingController>( () async => await ControllerFactory.create<RecordingController>( rpcClientRap, millisec, MetaPropertyManager().getMetaProperty(eTags.voice_record)!, true, ) , tag: MetaPropertyManager().getMetaProperty(eTags.voice_record)!.tag_name );

    await Get.putAsync<DaqEdgeController>( () async => await ControllerFactory.create<DaqEdgeController>( rpcClientRap, 2000, MetaPropertyManager().getMetaProperty(eTags.daq_edge)!, true, ) , tag: MetaPropertyManager().getMetaProperty(eTags.daq_edge)!.tag_name );


  }


}