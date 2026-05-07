



import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

abstract class RpcRapperController extends GetxController {

  late RpcClientRap<GatewayClient>? _rpcClientRap;
  RpcClientRap<GatewayClient>? get rpcClientRap => _rpcClientRap;


  RpcRapperController(this._rpcClientRap);


}