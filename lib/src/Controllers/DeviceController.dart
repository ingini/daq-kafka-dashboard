import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';

import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';

import 'package:daq_dashboard/src/Models/IModel.dart';

import 'package:daq_dashboard/src/Models/DeviceModel.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';

import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';



class DeviceController extends SensorController {

  DeviceController(
      RpcClientRap<GatewayClient>? rpcClientRap,
      int millisecond,
      metaProperty taggingMetaProperty,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active)
  {
    // startTask();
  }


  @override
  void processInit() {
    // eventTaskQueue.init();
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.DeviceConnected ,
        OnProcessDeviceConnected,OnSensorConnectedSuccess,OnSensorConnectedFail));
  }


  //
  //
  // Future<void> OnDeviceConnectedSuccess(EventTaskResponse response) async{
  //
  //   EventTaskResponseResult<Connection> typedResponse = response as EventTaskResponseResult<Connection>;
  //   Connection? connection = typedResponse.packet_data as Connection;
  //
  //   DeviceModel? deviceModel = processingParam.getModelAs<DeviceModel>();
  //   deviceModel?.connection = connection;
  //
  //   // AppendModel(deviceModel!);
  //   // update();
  // }



  @override
  SensorModel? DefaultModelFactoryMethod() {
    return ModelFactory.DefaultFactory( DeviceModel(tag) );
  }

  @override
  SensorModel? ModelFactoryMethod() {
    return ModelFactory.DefaultFactory( DeviceModel(tag) );
  }


  //
  //
  //
  // @override
  // Future<bool> actionConnection  (IModel? model) async
  // {
  //   Device device = Device(name: sensor_name);
  //   DeviceModel deviceModel = DeviceModel(tag);
  //
  //   Connection? connection =
  //   await rpcClientRap?.SendAsyncLocal<Connection, GatewayClient>(
  //           (rpcClient) => rpcClient.is_dev_connected(device)
  //   );
  //
  //   if (connection == null) {
  //     print("gRpc Server Response is Null!!!!!!!");
  //     return Future.value(false);
  //   }
  //
  //   deviceModel.connection = connection;
  //
  //   AppendModel(deviceModel);
  //
  //   // print("re paint !! ");
  //   update();
  //   return Future.value(true);
  // }



  //
  // @override
  // Future<void> actionSensor() async {
  //
  //   Device device = Device(name: sensor_name);
  //   DeviceModel deviceModel = DeviceModel(tag);
  //
  //   // _cameraModel = CameraModel(_tag);
  //
  //   try{
  //
  //     Connection? connection =
  //     await rpcClientRap?.SendAsyncLocal<Connection, GatewayClient>(
  //             (rpcClient) => rpcClient.is_dev_connected(device)
  //     );
  //
  //     if (connection == null) {
  //       print("gRpc Server Response is Null!!!!!!!");
  //       return;
  //     }
  //
  //     deviceModel.connection = connection;
  //
  //     AppendModel(deviceModel);
  //
  //     // print("re paint !! ");
  //     update();
  //   }
  //   catch(e)
  //   {
  //     print(e);
  //   }
  //
  // }


}