








import 'package:daq_dashboard/src/Controllers/GnssController.dart';
import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/dtos/ControllerFactoryDTO.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:get/get.dart';

import '../deleGate/DeleGate.dart';



abstract class MapTableHelper<K, V> {
  static Map<K, V> getTable<K, V>() {
    return {};
  }
}


class LidarIconMapTableHelper extends MapTableHelper<eTags ,lidarIconProperty> {

  static Map<eTags, lidarIconProperty> getTable() {
    return Defines.lidarIconPropertieTable();
  }

  static lidarIconProperty? getLidarIconProperty( String tag_name )
  {
    eTags? tag = MetaPropertyManager().getTagType( tag_name );
    return getTable()[tag];
  }

  static eLidarType? getLidarType( String tag_name )
  {
    eTags? tag = MetaPropertyManager().getTagType( tag_name );
    return getTable()[tag]?.lidar_type;
  }

  static double? rotateAngle( String tag_name )
  {
    eTags? tag = MetaPropertyManager().getTagType( tag_name );
    return getTable()[tag]?.rotate_angle;
  }
}



class ControllerMetaTablesHelper extends MapTableHelper<eTags ,Func3<eTags ,RpcClientRap<GatewayClient> , int , ControllerCreateDTO >> {

  static Map<eTags ,Func3<eTags ,RpcClientRap<GatewayClient>? , int , ControllerCreateDTO > > getTable() {
    return Defines.ControllerMetaTables();
  }


  static ControllerRegistedToGetPools ( RpcClientRap<GatewayClient>?  rpcClientRap , var millisecond )
  {

    for( var entry in getTable().entries )
    {
      ControllerCreateDTO controllerCreaterDTO = entry.value.Invoke(entry.key, rpcClientRap, millisecond);
      Get.put( controllerCreaterDTO.createController(rpcClientRap , millisecond) , tag: controllerCreaterDTO.getTagName );
    }

  }

  static Func3<eTags ,RpcClientRap<GatewayClient>? , int , ControllerCreateDTO > getControllerCreateDTO( eTags tag )
  {
    return getTable()[tag]!;
  }

  static GnssController gTest(RpcClientRap<GatewayClient>?  rpcClientRap , int millisec)
  {
    return  GnssController(    rpcClientRap , millisec , MetaPropertyManager().getMetaProperty(eTags.gnss)!    , true );
  }


  static T Cr<T extends SensorController> (RpcClientRap<GatewayClient>  rpcClientRap , int millisec)
  {
    Func2< RpcClientRap<GatewayClient>   , int  , T > f = Func2( (rpcClientRap ,millisec  )  {
      return GnssController(    rpcClientRap! , millisec , MetaPropertyManager().getMetaProperty(eTags.gnss)!    , true ) as T;
    }
    );

    return f.Invoke(rpcClientRap, millisec);
  }

  static GnssController? Cr2 (RpcClientRap<GatewayClient>?  rpcClientRap , int millisec)
  {

    Func2<RpcClientRap<GatewayClient>? , int , void  > f = Func2( (rpcClientRap ,millisec  )  {
      print("rpcClientRap : $rpcClientRap");
      print("millisec : $millisec");
    }
    );


    return null;

    //
    //
    // Func2< RpcClientRap<GatewayClient>?   , int  , GnssController > f = (rpcClientRap ,millisec  )  {
    //   return GnssController(    rpcClientRap , millisec , MetaPropertyManager().getMetaProperty(eTags.gnss)!    , true )!
    // };
    //
    // return f.Invoke(rpcClientRap, millisec);
  }



  static void gTest2(RpcClientRap<GatewayClient>?  rpcClientRap , int millisec)
  {

    // Get.put( ControllerMetaTablesHelper.gTest(rpcClientRap, millisec) , tag: MetaPropertyManager().getMetaProperty(eTags.gnss)!.tag_name );
    //
    // ControllerCreateDTO dto =   ControllerCreateDTO(MetaPropertyManager().getMetaProperty(eTags.gnss)!.tag_name , ControllerMetaTablesHelper.gTest(rpcClientRap, millisec) );
    // Get.put( dto.getController , tag: dto.getTagName );

    // ControllerCreateDTO2 dto2 = ControllerCreateDTO2();
    // dto2.setController = ControllerMetaTablesHelper.gTest(rpcClientRap, millisec);
    //
    // Get.put( dto2.getController , tag: MetaPropertyManager().getMetaProperty(eTags.gnss)!.tag_name );

    // Cr<GnssController>( rpcClientRap , millisec );


    Func2< RpcClientRap<GatewayClient>?   , int  , GnssController > f = Func2( (rpcClientRap ,millisec  )  {
      return GnssController(    rpcClientRap , millisec , MetaPropertyManager().getMetaProperty(eTags.gnss)!    , true ) ;
    }
    );


    Get.put( f.Invoke(rpcClientRap!, millisec) , tag: MetaPropertyManager().getMetaProperty(eTags.gnss)!.tag_name );


    // ControllerCreateDTO3 dto = ControllerCreateDTO3<GnssController>();
    // dto.setController = ControllerMetaTablesHelper.gTest(rpcClientRap, millisec);
    // Get.put( dto.getController , tag: MetaPropertyManager().getMetaProperty(eTags.gnss)!.tag_name );


    // Get.put( dto.getController, tag: MetaPropertyManager().getMetaProperty(eTags.gnss)!.tag_name );
    // Get.put( ControllerMetaTablesHelper.gTest(rpcClientRap, millisec), tag: MetaPropertyManager().getMetaProperty(eTags.gnss)!.tag_name );

    //
    // SensorController gc = ControllerMetaTablesHelper.gTest(rpcClientRap, millisec);
    //
    // Get.put( gc as GnssController , tag: MetaPropertyManager().getMetaProperty(eTags.gnss)!.tag_name );

    // Get.put( ControllerMetaTablesHelper.gTest(rpcClientRap, millisec) , tag: MetaPropertyManager().getMetaProperty(eTags.gnss)!.tag_name );



  }

  static void gTest3(RpcClientRap<GatewayClient>?  rpcClientRap , int millisec)
  {

    ControllerCreateDTO dto = getControllerCreateDTO(eTags.gnss)!.Invoke(eTags.gnss, rpcClientRap , millisec);


    // Get.put( dto.getController , tag: dto.getTagName );
  }

  //corRutine 을 만들고 이를 이용해서 Main 에서 Controller 를 올릴수 있게 해야함...




}





