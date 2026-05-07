




import 'package:daq_dashboard/src/Controllers/GnssController.dart';
import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/dataObjects/idto.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:get/get.dart';

class ControllerCreateDTO<T extends SensorController> extends IDTO {

   String _tag_name ;
   Func2<RpcClientRap<GatewayClient>?  , int  , T > _on_create_controller;

  ControllerCreateDTO(this._tag_name , this._on_create_controller);

  //getttter
  String get getTagName => _tag_name;

  T createController( RpcClientRap<GatewayClient>? rpcClientRap , int millisecond )
  {

    print("createController : ${_tag_name}");

    return _on_create_controller.Invoke ( rpcClientRap , millisecond ) as T;
  }


  //
  // //setter
  // set setTagName( String tag_name ) => _tag_name = tag_name;
  // set setController( GetxController controller ) => _controller = controller;

}


class ControllerCreateDTO2<T extends SensorController> extends IDTO {

  T? _controller;

  ControllerCreateDTO2()
  {

  }

  //getttter
  T get getController => _controller!;

  T getControllerAs()
  {
    return _controller! as T;
  }


  //setter
  set setController( T controller ) => _controller = controller;

}


class ControllerCreateDTO3<T extends SensorController> extends IDTO {

  T?  _controller;

  ControllerCreateDTO2()
  {

  }

  //getttter
  T get getController => _controller!;

  T getControllerAs()
  {
    return _controller! ;
  }


  //setter
  set setController( T controller ) => _controller = controller;

}
