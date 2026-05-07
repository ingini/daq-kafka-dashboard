import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';




typedef ControllerCreator<T> = Future<T> Function(
    RpcClientRap<GatewayClient>? rpcClientRap,
    int millisecond,
    metaProperty taggingMetaProperty,
    bool is_active,
    );


class ControllerFactory
{
  static final Map<Type, ControllerCreator> _creators = {};


  static void registerController<T extends SensorController>(
      ControllerCreator<T> creator) {
    _creators[T] = creator;
  }


  static Future<T> create<T extends SensorController>(
      RpcClientRap<GatewayClient>? rpcClientRap,
      int millisecond,
      metaProperty taggingMetaProperty, [
        bool is_active = false,
      ]) async {
    final creator = _creators[T];
    if (creator == null) {
      throw Exception('Unknown controller type');
    }
    return await creator(rpcClientRap, millisecond, taggingMetaProperty, is_active) as T;
  }
}






