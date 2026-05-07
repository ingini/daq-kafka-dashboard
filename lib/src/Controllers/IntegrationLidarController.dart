
import 'package:daq_dashboard/src/Controllers/LidarController.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/LidarModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';

class IntegrationLidarController extends LidarController {
  //
  IntegrationLidarController(
      RpcClientRap<GatewayClient>? rpcClientRap ,
      int millisecond,
      metaProperty taggingMetaProperty,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active);



  @override
  void processInit()
  {

    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorConnected,OnProcessIsSensorConnected,OnSensorConnectedSuccess,OnSensorConnectedFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorHealthy,OnProcessIsSensorHealthy,OnSensorHealthySuccess,OnSensorHealthyFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Acquiring,OnProcessIsSensorAcquiring,OnSensorAcquiringSuccess,OnSensorAcquiringFail));
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Snap,OnProcessSensorSnap,OnSnapSuccess,OnSnapFail));



  }


}