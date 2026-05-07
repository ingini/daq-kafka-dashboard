import 'dart:convert';

import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/Controllers/TaskController.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';
import 'package:daq_dashboard/src/Handler/HandlerType.dart';
import 'package:daq_dashboard/src/dtos/JSonFactory.dart';
import 'package:daq_dashboard/src/jsonModels/CanData.dart';
import 'package:daq_dashboard/src/jsonModels/GnssData.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/CanModel.dart';
import 'package:daq_dashboard/src/Models/GnssModel.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';

import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';


class CanController extends SensorController {

  CanController(
      RpcClientRap<GatewayClient>? rpcClientRap ,
      int millisecond,
      metaProperty taggingMetaProperty ,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active);


  @override
  void processInit()
  {
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorConnected, OnProcessIsSensorConnected,OnSensorConnectedSuccess,OnSensorConnectedFail));
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Acquiring,OnProcessIsSensorAcquiring,OnSensorAcquiringSuccess,OnSensorAcquiringFail));
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Snap,OnProcessSensorSnap,OnSnapSuccess,OnSnapFail));
  }


  Future<void> OnSnapSuccess(EventTaskResponse response) async {

    // print("OnSnapSuccess Gnss ");

    try
    {
      SensorSnapshot? snapShot = (response as EventTaskResponseResult<
          SensorSnapshot>).packet_data;

      if (snapShot != null) {
        String jsonString = utf8.decode(snapShot.data);

        var canData = JSonFactory.fromJsonFactory(
            CanData.fromJsonCallback, jsonString) as CanData;
        CanModel? canModel = processingParam.getModelAs<CanModel>();
        canModel?.bytes_per_sec = canData.bytes_per_sec;

        return;
      }
      else {
        print("OnSnapSuccess snapShot is null");
      }
    }
    catch (e) {
      print("GnssController::OnSnapSuccess() error [ $e ]");
    }

  }


  @override
  SensorModel<IModel>? DefaultModelFactoryMethod() {
    return ModelFactory.DefaultFactory( CanModel(tag) );
  }

  @override
  SensorModel<IModel>? ModelFactoryMethod() {
    return ModelFactory.DefaultFactory( CanModel(tag) );
  }




}