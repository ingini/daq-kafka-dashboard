

import 'dart:typed_data';

import 'dart:ui' as ui;

import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/Controllers/TaskController.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';
import 'package:daq_dashboard/src/dtos/ConnectionDTO.dart';
import 'package:daq_dashboard/src/dtos/RowImageDTO.dart';
import 'package:daq_dashboard/src/meta/AppManager.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/meta/Modes.dart';
import 'package:daq_dashboard/src/Models/CameraModel.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/ModelQueue.dart';
import 'package:daq_dashboard/src/Models/MovieClipModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';

import 'package:daq_dashboard/src/network/networkConts.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:flutter/cupertino.dart';

import '../protos/daq-service.pbgrpc.dart';

import 'package:daq_dashboard/src/ProcessingState/ProcessingState.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';


abstract class MovieClipController<T extends MovieClipModel > extends SensorController<MovieClipModel> {

  RowImageDTOPool _rowImageContainer = RowImageDTOPool();
  RowImageDTO? _rowImageDTO;

  MovieClipController(
      RpcClientRap<GatewayClient>? rpcClientRap ,
      int millisecond,
      metaProperty taggingMetaProperty ,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active);



  @override
  void processInit()
  {


    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorConnected,OnProcessIsSensorConnected,OnSensorConnectedSuccess,OnSensorConnectedFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorHealthy,OnProcessIsSensorHealthy,OnSensorHealthySuccess,OnSensorHealthyFail));
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Acquiring,OnProcessIsSensorAcquiring,OnSensorAcquiringSuccess,OnSensorAcquiringFail));
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Snap,OnProcessSensorSnap,OnSnapSuccess,OnSnapFail));

  }


  Future<void> OnSnapSuccess(EventTaskResponse response) async{

    try {
      SensorSnapshot? snapShot = (response as EventTaskResponseResult<
          SensorSnapshot>).packet_data;

      if (snapShot == null) {
        OnSnapFail(response);

        return;
      }

      var uint8list = Uint8List.fromList(snapShot.data);
      var image = await _loadImageFromBytes(uint8list);

      RowImageDTO dto = RowImageDTO(image, snapShot.name);
      _rowImageContainer.Append(dto);
      _rowImageDTO = dto;

      T? movieModel = processingParam.getModelAs<T>();

      movieModel?.row_image = dto;



    }
    catch (e) {
      OnSnapFail(response);
      print("OnSnapSuccess error [ $e ]");
    }

  }





  Future<ui.Image> _loadImageFromBytes(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return Future.value(frame.image);
  }

  RowImageDTO? PopRowImageDTO() {
    RowImageDTO? dto = _rowImageDTO;
    _rowImageDTO = null;
    return dto;

  }
  //
  // @override
  // Future<void> actionSensor() async {
  //
  //   try
  //   {
  //     Sensor sensor = Sensor(name: sensor_name);
  //
  //     T model = createFactoryModel(tag) as T ;
  //
  //
  //     if( await actionState(sensor,model) &&
  //         await actionSnap(sensor,model) )
  //     {
  //       AppendModel(model);
  //       update();
  //     }
  //
  //   } catch (e) {
  //     print("ImageController::action() error [ $e ]");
  //   }
  // }

  @override
  Future<bool> actionConnection(IModel? model) async
  {

    Sensor s = Sensor(name: sensor_name);

    Connection? connection =
        await rpcClientRap?.SendAsyncLocal<Connection, GatewayClient>(
            (rpcClient) => rpcClient.is_sensor_connected(s)
    ) as Connection?;

    if (connection == null) {
      print("gRpc Server Response is Null!!!!!!!");
      return Future.value(false);
    }

    (model as T).connection = Connection( state: connection.state , name: connection.name);

    return Future.value(true);

  }

  @override
  Future<bool> actionHealthy(IModel? model) async
  {
    Sensor s = Sensor(name: sensor_name);

    Health? health =
        await rpcClientRap?.SendAsyncLocal<Health, GatewayClient>(
            (rpcClient) => rpcClient.is_sensor_healthy(s)
    );

    if (health == null) {
      print("gRpc Server Response is Null!!!!!!!");
      return Future.value(false);
    }

    T mModel = model as T;

    mModel?.health = health;


    Acquisition? acquisition =
        await rpcClientRap?.SendAsyncLocal<Acquisition, GatewayClient>(
            (rpcClient) => rpcClient.is_sensor_acquiring(s)
    );

    if (acquisition == null) {
      print("gRpc Server Response is Null!!!!!!!");
      return Future.value(false);
    }
    mModel?.acquisition = acquisition;
    return Future.value(true);
  }

  @override
  Future<bool> actionSnap(IModel? model) async
  {
    Sensor s = Sensor(name: sensor_name);

    T mModel = model as T;

    SensorSnapshot? snapShot =
        await rpcClientRap?.SendAsyncLocal<SensorSnapshot, GatewayClient>(
            (rpcClient) => rpcClient.get_sensor_snapshot(s)
    );

    if (snapShot == null) {
      print("gRpc Server Response is Null!!!!!!!");
      return Future.value(false);
    }


    if (await AppManager.instance.isDebugAsync() ) {
      print("[DEBUG] snapShot Data Length : ${snapShot.data.length} ");
    }


    var uint8list = Uint8List.fromList(snapShot.data);
    var image = await _loadImageFromBytes(uint8list);

    RowImageDTO dto = RowImageDTO(image, snapShot.name);
    _rowImageContainer.Append(dto);
    _rowImageDTO = dto;

    mModel?.row_image = dto;
    return Future.value(true);
  }





}