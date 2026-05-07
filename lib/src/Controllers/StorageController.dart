
import 'dart:convert';

import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';
import 'package:daq_dashboard/src/Handler/HandlerType.dart';
import 'package:daq_dashboard/src/dtos/JSonFactory.dart';
import 'package:daq_dashboard/src/jsonModels/StorageData.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/Models/StorageModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';

import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';

class StorageController extends SensorController {


  StorageController(
      RpcClientRap<GatewayClient>? rpcClientRap,
      int millisecond,
      metaProperty taggingMetaProperty,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active)
  {
    startTask();
  }


  @override
  void processInit() {


    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.DeviceConnected , OnProcessDeviceConnected,OnDeviceConnectedSuccess,OnDeviceConnectedFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.DeviceHealthy , OnProcessDeviceHealthy,OnDeviceHealthySuccess,OnDeviceHealthyFail));
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorConnected, OnProcessIsSensorConnected,OnSensorConnectedSuccess,OnSensorConnectedFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorHealthy, OnProcessIsSensorHealthy,OnSensorHealthySuccess,OnSensorHealthyFail));

    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Acquiring, OnProcessIsSensorAcquiring,OnSensorAcquiringSuccess,OnSensorAcquiringFail));

    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Snap,OnProcessSensorSnap,OnSnapSuccess,OnSnapFail));

  }

  Future< void> OnSnapSuccess(EventTaskResponse response) async {
    // print("OnSnapSuccess");

    try {
      EventTaskResponseResult<
          SensorSnapshot> result = response as EventTaskResponseResult<
          SensorSnapshot>;


      String jsonString = utf8.decode(result.packet_data!.data);

      // print("LLLL ${jsonString}");

      var storageData = JSonFactory.fromJsonFactory(
          StorageData.fromJsonCallback, jsonString) as StorageData;

      processingParam
          .getModelAs<StorageModel>()
          ?.storageData = storageData;
      // model?.storageData = storageData;

      // AppendModel(processingParam.getModelAs<StorageModel>()!);
      // update();



    }
    catch (e) {
      print("StorageController::OnSnapSuccess() error [ $e ]");
      OnSnapFail(response);
    }

  }


  @override
  SensorModel? DefaultModelFactoryMethod()
  {
    return ModelFactory.Create<StorageModel>( StorageModel(tag) );
  }

  @override
  SensorModel? ModelFactoryMethod()
  {
    return ModelFactory.Create<StorageModel>( StorageModel(tag) );
  }


}





