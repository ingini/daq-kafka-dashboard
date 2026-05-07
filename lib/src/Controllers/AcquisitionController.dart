import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';


class AcquisitionController extends SensorController {

  AcquisitionController(
      RpcClientRap<GatewayClient>? rpcClientRap ,
      int millisecond,
      metaProperty taggingMetaProperty ,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active);


  @override
  void processInit()
  {
    eventTaskQueue.init();
  }

  @override
  SensorModel<IModel>? DefaultModelFactoryMethod() {
    return ModelFactory.DefaultFactory( SensorModel(tag) );
  }

  @override
  SensorModel<IModel>? ModelFactoryMethod() {
    return ModelFactory.DefaultFactory( SensorModel(tag) );
  }

}