
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/network/SSHRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';



class SSHHandlerController extends SensorController
{
  late SSHRap _sshRap;

  SSHRap get sshRap => _sshRap;


  SSHHandlerController(
      RpcClientRap<GatewayClient>? rpcClientRap ,
      int millisecond,
      metaProperty taggingMetaProperty ,
      SSHRap sshRap,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active)
  {
    _sshRap = sshRap;
  }



  @override
  SensorModel<IModel>? DefaultModelFactoryMethod() {
    // TODO: implement DefaultModelFactoryMethod
    throw UnimplementedError();
  }

  @override
  SensorModel<IModel>? ModelFactoryMethod() {
    // TODO: implement ModelFactoryMethod
    throw UnimplementedError();
  }

  @override
  void processInit() {
    // super.processInit();
  }


}
