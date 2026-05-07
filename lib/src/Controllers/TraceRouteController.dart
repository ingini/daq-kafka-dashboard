import 'package:daq_dashboard/src/dtos/PingDTO.dart';
import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/Controllers/TaskController.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';
import 'package:daq_dashboard/src/Handler/HandlerType.dart';
import 'package:daq_dashboard/src/jsonModels/GnssData.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/GnssModel.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/Models/TraceRouteModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/protos/daq-service.pbgrpc.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';


class TraceRouteController extends SensorController {

final PingDTO _pingdto;

  TraceRouteController(
      PingDTO pingdto ,
      int millisecond,
      metaProperty taggingMetaProperty,
      [ bool is_active = false ])
      :  _pingdto=pingdto , super( null , millisecond , taggingMetaProperty , is_active);


  void startTask() {

    final ping = Ping("8.8.8.8", interval: 1 ,timeout: 1, forceCodepage: true);
    // final ping = Ping( _pingdto.address, interval: 1 ,timeout: 1, forceCodepage: true);

    ping.stream.listen((event) async {
      print(event);
      await actionPing(event);
    });
  }

  @override
  void processInit()
  {
    eventTaskQueue.init();
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.None,OnProcessUpdateParam,OnSuccess,OnFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Snap,OnProcessSensorSnap,OnSnapSuccess,OnFail));
  }




  // Future<EventTaskResponse> OnProcessSensorSnap() async
  // {
  //   print("OnProcessSensorSnap");
  //
  //   SensorSnapshot? snapShot;
  //
  //   try {
  //     snapShot =
  //     await rpcClientRap?.SendAsyncLocal<SensorSnapshot, GatewayClient>(
  //             (rpcClient) => rpcClient.get_sensor_snapshot(processingParam.getSensor()!)
  //     );
  //
  //     if( snapShot == null )
  //       return EventTaskResponseResult<SensorSnapshot>( false , snapShot);
  //
  //     return EventTaskResponseResult<SensorSnapshot>( true , snapShot);
  //   }
  //   catch (e) {
  //     print("OnProcessSensorSnap error [ $e ]");
  //     return EventTaskResponseResult<SensorSnapshot>( false , snapShot);
  //   }
  // }
  //
  //
  // Future<void> OnSnapSuccess(EventTaskResponse response) async {
  //
  // }


//TODO 이부분을 연결 할수 잇나?
  //eventTaskQueue 랑....
  //
  Future<bool> actionSnap(Sensor sensor, TraceRouteModel model,PingData pingdata) async {



    // print("awdawdawdwa");

    try {

       model.pingData = pingdata;

       if( pingdata.error != null )
         return false;

       // print( " ping seq : ${pingdata.response?.seq}");
       // print( " ping ip : ${pingdata.response?.ip}");
       // print( " ping time : ${pingdata.response?.time}");

       // double db = pingdata.response!.time!.inMicroseconds!.toDouble() / 1000.0;
       //
       // print( " ping time_ms : ${db}");
       // print("pingdt : ${pingdata}") ;

      return true;
    }
    catch (e) {
      print("TraceRouteController::actionSnap() error [ $e ]");
      return false;
    }
  }


  Future<void> actionPing( PingData pingdata ) async {

    if ( is_active == false )
      return;

    IModel model = TraceRouteModel(tag , _pingdto.address);
    Sensor sensor = Sensor(name: sensor_name);

    try
    {

      if( await actionSnap(sensor,model as TraceRouteModel ,pingdata) )
      {
        model.isSuccess = true;
        AppendModel(model);
        update();
      }
      else
      {
        model.isSuccess = false;
        AppendModel(model);
        update();
        print("TraceRouteController actionSensor() error");
      }
      //   AppendModel(model);
      // update();
    } catch (e) {

      (model as TraceRouteModel).isSuccess = false;
      AppendModel(model);
      update();
      print("TraceRouteController::action() error [ $e ]");
    }
  }
  //
  // @override
  // IModel? getDefaultModel() {
  //   return ModelFactory.DefaultFactory( TraceRouteModel(tag ) );
  // }
  //

  @override
  SensorModel? DefaultModelFactoryMethod() {
    return ModelFactory.DefaultFactory( TraceRouteModel(tag ) );
  }

  @override
  SensorModel? ModelFactoryMethod() {
    return ModelFactory.DefaultFactory( TraceRouteModel(tag ) );
  }

  //
  // @override
  // void processInit() {
  //   eventTaskQueue.init();
  // }


}