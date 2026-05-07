import 'dart:convert';

import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/Controllers/TaskController.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';
import 'package:daq_dashboard/src/Handler/HandlerType.dart';
import 'package:daq_dashboard/src/dtos/JSonFactory.dart';
import 'package:daq_dashboard/src/jsonModels/GnssData.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/GnssModel.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';

import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';

class GnssController extends SensorController {



  GnssController(
      RpcClientRap<GatewayClient>? rpcClientRap ,
      int millisecond,
      metaProperty taggingMetaProperty ,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active)
  {
    print("GnssController::GnssController()" );
  }


  @override
  void processInit()
  {
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorConnected, OnProcessIsSensorConnected,OnSensorConnectedSuccess,OnSensorConnectedFail));
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Acquiring,OnProcessIsSensorAcquiring,OnSensorAcquiringSuccess,OnSensorAcquiringFail));
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorHealthy,OnProcessIsSensorHealthy,OnSensorHealthySuccess,OnSensorHealthyFail));

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

        var gnssData = JSonFactory.fromJsonFactory(
            GnssData.fromJsonCallback, jsonString) as GnssData;


        GnssModel? gnssModel = processingParam.getModelAs<GnssModel>();

        gnssModel?.longitude = gnssData.lon;
        gnssModel?.latitude = gnssData.lat;
        gnssModel?.solnsvs_count = gnssData.solnsvs;

        // var gnssData = GnssData.fromJson(jsonString);
        // print(gnssData.lat);
        // print(gnssData.lon);
        // print(gnssData.solnsvs);
        //
        // GnssModel model = GnssModel(tag);
        // model.longitude = gnssData.lon;
        // model.latitude = gnssData.lat;
        // model.solnsvs_count = gnssData.solnsvs;

        // AppendModel(model);
        // update();
        // print("OnSnapSuccess snapShot is null");
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

  Future<void> OnSnapFail(EventTaskResponse response) async {
    print("OnSnapFail");
  }
  //
  // @override
  // Future<bool> actionSnap(Sensor sensor, GnssModel model) async {
  //
  //   try {
  //     // Sensor s = Sensor(name: sensor_name);
  //     SensorSnapshot? snapShot =
  //     await rpcClientRap?.SendAsyncLocal<SensorSnapshot, GatewayClient>(
  //             (rpcClient) => rpcClient.get_sensor_snapshot(sensor)
  //     );
  //
  //     if (snapShot == null) {
  //       print("gRpc Server Response is Null!!!!!!!");
  //       return false;
  //     }
  //
  //     String jsonString = utf8.decode(snapShot.data);
  //
  //     // print( "JJJJJ ${jsonString}" );
  //
  //     var gnssData = JSonFactory.fromJsonFactory(GnssData.fromJsonCallback , jsonString) as GnssData;
  //
  //     // var gnssData = GnssData.fromJson(jsonString);
  //     // print(gnssData.lat);
  //     // print(gnssData.lon);
  //     // print(gnssData.solnsvs);
  //
  //     model.longitude = gnssData.lon;
  //     model.latitude = gnssData.lat;
  //     model.solnsvs_count = gnssData.solnsvs;
  //
  //     return true;
  //
  //
  //   }
  //   catch (e) {
  //     print("GnssController::actionSnap() error [ $e ]");
  //     return false;
  //   }
  // }
  //
  //
  // @override
  // Future<void> actionSensor() async {
  //
  //   try
  //   {
  //     Sensor sensor = Sensor(name: sensor_name);
  //     GnssModel model = GnssModel(tag);
  //
  //     // print("gnss");
  //
  //     if( await actionState(sensor,model) &&
  //         await actionSnap(sensor,model) )
  //     {
  //       AppendModel(model);
  //       update();
  //     }
  //     else
  //     {
  //       print("gnss actionSensor() error");
  //     }
  //     //   AppendModel(model);
  //     // update();
  //   } catch (e) {
  //     print("ImageController::action() error [ $e ]");
  //   }
  //
  // }


  @override
  SensorModel? DefaultModelFactoryMethod() {
    return ModelFactory.DefaultFactory( GnssModel(tag) );
  }

  @override
  SensorModel? ModelFactoryMethod() {
    return ModelFactory.DefaultFactory( GnssModel(tag) );
  }



}