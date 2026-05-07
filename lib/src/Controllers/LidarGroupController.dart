
import 'dart:ui' as ui;
import 'package:daq_dashboard/src/Controllers/MovieClipController.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/LidarGroupModel.dart';
import 'package:daq_dashboard/src/Models/LidarModel.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';



class LidarGroupController extends MovieClipController<LidarGroupModel> {


  LidarGroupController(
      RpcClientRap<GatewayClient>? rpcClientRap ,
      int millisecond,
      metaProperty taggingMetaProperty,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active);


  @override
  void processInit()
  {

    //
    // //each
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorConnected,OnProcessIsSensorConnected,OnSensorConnectedSuccess,OnSensorConnectedFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Acquiring,OnProcessIsSensorAcquiring,OnSensorAcquiringSuccess,OnSensorAcquiringFail));

    //all
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Snap,OnProcessSensorSnap,OnSnapSuccess,OnSnapFail));

    // movieClipController
    //
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorConnected,OnProcessIsSensorConnected,OnSensorConnectedSuccess,OnSensorConnectedFail));
    // // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorHealthy,OnProcessIsSensorHealthy,OnSensorHealthySuccess,OnSensorHealthyFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Acquiring,OnProcessIsSensorAcquiring,OnSensorAcquiringSuccess,OnSensorAcquiringFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Snap,OnProcessSensorSnap,OnSnapSuccess,OnSnapFail));


    // eventTaskQueue.init();
    //
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.ControlActive ,OnProcessControlActive,OnControlActiveSuccess,OnControlActiveFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.NetworkConnected,OnProcessNetworkConnected,OnNetworkConnectedSuccess,OnNetworkConnectedFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.None,OnProcessUpdateParam,OnSuccess,OnFail));
  }


  Future<void> OnProcessIsSensorConnectedEach(LidarModel model) async {
    Connection? connection;

    Sensor sensor = Sensor(name: model.tag);

    // print("Each M : ${model.tag}");

    try {
      connection =
      await rpcClientRap?.SendAsyncLocal<Connection, GatewayClient>(
              (rpcClient) =>
              rpcClient.is_sensor_connected(sensor!)
      );

      model.connection = connection;


      //State 를 셋해줘야함....
      // if ( connection == null || (connection.state != Connection_State.CONNECTED  )  )

      //   return EventTaskResponseResult<Connection>( false , connection);
      //
      // return EventTaskResponseResult<Connection>( true , connection);
    }
    catch (e) {
      model.connection = connection;
      print("OnProcessIsSensorConnected error [ $e ]");
      // return EventTaskResponseResult<Connection>( false , connection);
    }
  }

  Future<EventTaskResponse> OnProcessIsSensorConnected() async
  {
    // print("OnProcessIsSensorConnected");

    LidarGroupModel? groupModel = processingParam.getModelAs<LidarGroupModel>();


    //Action1<IModel>

    groupModel?.groupModel.coRoutine(
      eTags.lidar ,
        await Action1Async((elements_model) async {

        if(groupModel.tag.compareTo((elements_model as LidarModel).tag) == 0 )
          return;

        await OnProcessIsSensorConnectedEach(elements_model as LidarModel);
        // print("OnProcessIsSensorConnected [ $elements_model ] "    );
      })
    );

    return EventTaskResponseResult<Connection>( true );

    //
    //
    // Connection? connection;
    //
    // try {
    //   connection =
    //   await rpcClientRap?.SendAsyncLocal<Connection, GatewayClient>(
    //           (rpcClient) =>
    //           rpcClient.is_sensor_connected(processingParam.getSensor()!)
    //   );
    //
    //   if ( connection == null || (connection.state != Connection_State.CONNECTED  )  )
    //     return EventTaskResponseResult<Connection>( false , connection);
    //
    //   return EventTaskResponseResult<Connection>( true , connection);
    // }
    // catch (e) {
    //   print("OnProcessIsSensorConnected error [ $e ]");
    //   return EventTaskResponseResult<Connection>( false , connection);
    // }

  }


  Future<void> OnSensorConnectedSuccess(EventTaskResponse response) async {

    // EventTaskResponseResult<Connection> typedResponse = response as EventTaskResponseResult<Connection>;
    // Connection? connection = typedResponse.packet_data as Connection;
    //
    // SensorModel? model = processingParam.getModelAs<SensorModel>();
    // model?.connection = connection;

  }


  Future<void> OnSensorConnectedFail(EventTaskResponse response) async {
    // print("OnSensorConnectedFail");
  }




  Future<EventTaskResponse> OnProcessIsSensorAcquiring() async
  {
    // print("OnProcessIsSensorAcquiring");

    Acquisition? acquisition;

    try {
      acquisition =
      await rpcClientRap?.SendAsyncLocal<Acquisition, GatewayClient>(
              (rpcClient) => rpcClient.is_sensor_acquiring(processingParam.getSafeSensor()!)
      );

      if( acquisition == null )
        return EventTaskResponseResult<Acquisition>( false , acquisition);

      return EventTaskResponseResult<Acquisition>( true , acquisition);
    }
    catch (e) {
      print("OnProcessIsSensorHealthy error [ $e ]");
      return EventTaskResponseResult<Acquisition>( false , acquisition);
    }
  }


  Future<void> OnSensorAcquiringSuccess(EventTaskResponse response) async {
    print("OnSensorAcquiringSuccess");
    // EventTaskResponseResult<Acquisition> typedResponse = response as EventTaskResponseResult<Acquisition>;
    // Acquisition? acquisition = typedResponse.packet_data as Acquisition;
    //
    // SensorModel? model = processingParam.getModelAs<SensorModel>();
    // model?.acquisition = acquisition;
  }

  Future<void> OnSensorAcquiringFail(EventTaskResponse response) async {
    print("OnSensorAcquiringFail");
  }




  @override
  SensorModel? DefaultModelFactoryMethod() {
    return ModelFactory.DefaultFactory( LidarGroupModel(tag) );
  }

  @override
  SensorModel? ModelFactoryMethod() {
    return ModelFactory.DefaultFactory( LidarGroupModel(tag) );
  }




}
