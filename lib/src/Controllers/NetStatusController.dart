import 'package:daq_dashboard/src/dtos/PingDTO.dart';
import 'package:daq_dashboard/src/Configure/configUtil.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';

import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/dtos/PingDataDTO.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';

import 'package:daq_dashboard/src/Models/IModel.dart';

import 'package:daq_dashboard/src/Models/DeviceModel.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/NetStatusModel.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';


import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:provider/provider.dart';



class NetStatusController extends SensorController<NetStatusModel> {



  PingDataDTOLastest _pingDataDTOLastest = PingDataDTOLastest();

  NetStatusController(
      RpcClientRap<GatewayClient>? rpcClientRap,
      int millisecond,
      metaProperty taggingMetaProperty,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active)
  {
    // startTask();
    OnInit();
    startTask();

    // startTask11();
  }







  void startTask11() {
    final ping = Ping("192.168.20.1", interval: 1 ,timeout: 1, forceCodepage: true);


    ping.stream.listen((event) async {
      print(event);
      // await actionPing(event , PingDTO(name: "a" , address: "a"));
    });

  }

  Future<void> OnInit() async {

    List<PingDTO> pingDtos = [
      await ConfigUtil.instance.getPingDto(eConfigKey.ping_gateway) as PingDTO ,
      await ConfigUtil.instance.getPingDto(eConfigKey.ping_wan) as PingDTO ,
      await ConfigUtil.instance.getPingDto(eConfigKey.ping_cpu) as PingDTO ,
    ];

    for (PingDTO pingDto in pingDtos)
    {
      final ping = Ping( pingDto.address, interval: 1 ,timeout: 1, forceCodepage: true);

      ping.stream.listen((event) async {
        await actionPing(event,pingDto);
      });

    }

    //
    // final ping = Ping("8.8.8.8", interval: 1 ,timeout: 1, forceCodepage: true);
    //
    // await ping.stream.listen((event) async {
    //   print(event);
    //   // await actionPing(event);
    // });


  }

  Future<void> actionPing( PingData pingdata,PingDTO pingDto ) async {
    if ( is_active == false )
      return;

    eTags? key = Defines.getTagFromPingKey(pingDto.name);

    _pingDataDTOLastest.UpSert(key!, PingDataDTO<eTags>(key!,pingdata, pingDto));

    // print(pingdata);


    // print( " ping nm : " + pingDto.name + " ${pingdata}");
  }

  @override
  void processInit() {
    eventTaskQueue.init();

    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.ControlActive ,OnProcessControlActive,OnControlActiveSuccess,OnControlActiveFail));

    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.UserCustom, OnProcessUserCustom,OnProcessUserCustomSuccess,OnProcessUserCustomFail));


    // 네트워크가 죽었다면
    // 다음은 진행을 하면 안됩니다.
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.NetworkConnected,OnProcessNetworkConnected,OnNetworkConnectedSuccess,OnNetworkConnectedFail));


    //이후 부터 Each 가 진행이 됩니다.
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.DeviceConnected, OnProcessDeviceConnected,OnDeviceConnectedSuccess,OnDeviceConnectedFail));
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.DeviceHealthy,OnProcessDeviceHealthy,OnDeviceHealthySuccess,OnDeviceHealthyFail));

    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.DeviceConnected ,
    //     OnProcessDeviceConnected,OnSensorConnectedSuccess,OnSensorConnectedFail));

  }
  //
  // Future<EventTaskResponse> OnProcessControlActive() async
  // {
  //   // print("OnProcessIsActive tag : $tag _is_active :");
  //   return EventTaskResult(true);
  // }

  Future<EventTaskResponse> OnProcessUserCustom() async
  {

    SensorModel? groupModel = processingParam.getModelAs<NetStatusModel>();


    _pingDataDTOLastest.coRoutine(
        await Action1Async((pingDataDTO) async {

          SensorModel elementModel = groupModel!.getElementModel( MetaPropertyManager().getTagName( pingDataDTO.tags )! ) as SensorModel;
          elementModel.setPingData(pingDataDTO.pingData) ;

        })
    );


    //
    //
    // List<String> tags = ["dev/vpu_a" , "dev/vpu_b" , "dev/vpu_c"];
    //
    // await groupModel?.groupModel.coRoutine(
    //     eTags.lidar,
    //     await Action1Async((elements_model) async {
    //       if (groupModel.tag.compareTo((elements_model as SensorModel).tag) == 0)
    //         return;
    //
    //       if( tags.contains(elements_model.tag) == false )
    //         return;
    //
    //       await OnProcessDeviceConnectedEach(elements_model );
    //       // print("OnProcessIsSensorConnected [ ${elements_model.tag} ] "    );
    //     })
    // );

    return EventTaskResponseResult<Connection>(true);

    // return EventTaskResult(true);
  }



  Future<void> OnProcessDeviceConnectedEach(SensorModel model) async {
    Connection? connection;

    // Sensor sensor = Sensor(name: model.tag);
    Device device = Device(name: model.sensor_name);

    // print("Each M : ${model.tag}");

    try {
      connection =
      await rpcClientRap?.SendAsyncLocal<Connection, GatewayClient>(
              (rpcClient) =>
              rpcClient.is_dev_connected(device!)
      );

      model.device_connection = connection;

      // print("Dev Connection : ${connection?.state } : sn : ${model.sensor_name} ");

      //State 를 셋해줘야함....
      // if ( connection == null || (connection.state != Connection_State.CONNECTED  )  )

      //   return EventTaskResponseResult<Connection>( false , connection);
      //
      // return EventTaskResponseResult<Connection>( true , connection);
    }
    catch (e) {
      model.device_connection = connection;
      print("OnProcessIsSensorConnected error [ $e ]");
      // return EventTaskResponseResult<Connection>( false , connection);
    }
  }

  Future<EventTaskResponse> OnProcessDeviceConnected() async
  {
    // print("OnProcessIsSensorConnected");

    SensorModel? groupModel = processingParam.getModelAs<NetStatusModel>();


    //Action1<IModel>


    List<String> tags = ["dev/vpu_a" , "dev/vpu_b" , "dev/vpu_c"];

    await groupModel?.groupModel.coRoutine(
        eTags.lidar,
        await Action1Async((elements_model) async {
          if (groupModel.tag.compareTo((elements_model as SensorModel).tag) == 0)
            return;

          if( tags.contains(elements_model.tag) == false )
            return;

          await OnProcessDeviceConnectedEach(elements_model );
          // print("OnProcessIsSensorConnected [ ${elements_model.tag} ] "    );
        })
    );

    return EventTaskResponseResult<Connection>(true);
  }



  Future<void> OnDeviceConnectedSuccess(EventTaskResponse response) async {

  }





  Future<void> OnProcessDeviceHealthyEach(SensorModel model) async {
    Health? health;

    // Sensor sensor = Sensor(name: model.tag);
    Device device = Device(name: model.sensor_name);

    // print("Each M : ${model.tag}");

    try {
      health =
      await rpcClientRap?.SendAsyncLocal<Health, GatewayClient>(
              (rpcClient) =>
              rpcClient.is_dev_healthy(device!)
      );

      model.device_health = health;

      // print("Dev Health : ${health?.status } : sn : ${model.sensor_name} ");

      //State 를 셋해줘야함....
      // if ( connection == null || (connection.state != Connection_State.CONNECTED  )  )

      //   return EventTaskResponseResult<Connection>( false , connection);
      //
      // return EventTaskResponseResult<Connection>( true , connection);
    }
    catch (e) {
      model.device_health = health;
      print("OnProcessIsSensorConnected error [ $e ]");
      // return EventTaskResponseResult<Connection>( false , connection);
    }
  }

  Future<EventTaskResponse> OnProcessDeviceHealthy() async
  {
    SensorModel? groupModel = processingParam.getModelAs<NetStatusModel>();

    List<String> tags = ["dev/cpu" , "dev/vpu_a" , "dev/vpu_b" , "dev/vpu_c"];

    await groupModel?.groupModel.coRoutine(
        eTags.lidar,
        Action1Async ((elements_model) async {
          if (groupModel.tag.compareTo((elements_model as SensorModel).tag) == 0)
            return;

          if( tags.contains(elements_model.tag) == false )
            return;

          await OnProcessDeviceHealthyEach(elements_model );
          // print("OnProcessIsSensorConnected [ ${elements_model.tag} ] "    );
        })
    );

    return EventTaskResponseResult<Connection>(true);
  }



  Future<void> OnDeviceHealthySuccess(EventTaskResponse response) async {



  }



  Future<void> OnProcessUserCustomSuccess(EventTaskResponse response) async {

    // EventTaskResponseResult<Connection> typedResponse = response as EventTaskResponseResult<Connection>;
    // Connection? connection = typedResponse.packet_data as Connection;
    //
    // SensorModel? model = processingParam.getModelAs<SensorModel>();
    // model?.connection = connection;

  }

  Future<void> OnProcessUserCustomFail(EventTaskResponse response) async {
    // print("OnSensorConnectedFail");
  }

  @override
  SensorModel<IModel>? DefaultModelFactoryMethod() {
    return ModelFactory.DefaultFactory( NetStatusModel(tag) );
  }

  @override
  SensorModel<IModel>? ModelFactoryMethod() {
    return ModelFactory.DefaultFactory( NetStatusModel(tag) );
  }




}