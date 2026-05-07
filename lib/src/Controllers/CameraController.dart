

import 'dart:ui' as ui;

import 'package:daq_dashboard/src/Controllers/MovieClipController.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';

import 'package:daq_dashboard/src/Models/CameraModel.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/MovieClipModel.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';


class CameraController extends MovieClipController<CameraModel> {

  var isFlipped = false;


  CameraController(
      RpcClientRap<GatewayClient>? rpcClientRap ,
      int millisecond,
      metaProperty taggingMetaProperty ,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active)
  {
    print("CameraController::CameraController()" );
  }


  void toggleFlip() {
    print("CameraController onCallBack()!!");
    isFlipped = !isFlipped;
    update(); // 상태를 업데이트하여 UI에 반영되도록 함
    print("isFlipped : ${isFlipped}");
  }

  bool getIsFlipped() {
    return isFlipped;
  }

  @override
  void processInit()
  {
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorConnected,OnProcessIsSensorConnected,OnSensorConnectedSuccess,OnSensorConnectedFail));

    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Acquiring,OnProcessIsSensorAcquiring,OnSensorAcquiringSuccess,OnSensorAcquiringFail));


    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorHealthy,OnProcessIsSensorHealthy,OnSensorHealthySuccess,OnSensorHealthyFail));


    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Snap,OnProcessSensorSnap,OnSnapSuccess,OnSnapFail));

  }


  Future<EventTaskResponse> OnProcessIsSensorHealthy() async
  {
    // print("OnProcessIsSensorHealthy");

    Health? health;

    try {
      health =
      await rpcClientRap?.SendAsyncLocal<Health, GatewayClient>(
              (rpcClient) => rpcClient.is_sensor_healthy(processingParam.getSafeExceptionSensorToCpuSensor()!)
      );

      processingParam.setSensorHealth(health);

      if (health== null || (health.status != Health_Status.GOOD) )
        return EventTaskResponseResult<Health>( false , health);

      return EventTaskResponseResult<Health>( true , health);
    }
    catch (e) {
      print("OnProcessIsSensorHealthy error [ $e ]");
      return EventTaskResponseResult<Health>( false , health);
    }
  }



  @override
  SensorModel? DefaultModelFactoryMethod() {
    return ModelFactory.DefaultFactory( CameraModel(tag) );
  }

  @override
  MovieClipModel? ModelFactoryMethod() {
    return ModelFactory.DefaultFactory( CameraModel(tag) );
  }

}
