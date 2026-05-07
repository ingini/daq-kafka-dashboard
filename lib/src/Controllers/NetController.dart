
import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/Controllers/TaskController.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/network/networkConts.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:grpc/service_api.dart';

import '../dtos/ConnectInfoDTO.dart';



class NetController extends TaskController {
//
// class NetController extends  SensorController{
  // var isConnected = false.obs;
  // late GrpcClient grpcClient;


  String? _selectedServerId;

  String? get selectedServerId => _selectedServerId;
  //setter
  set selectedServerId(String? value) {
    _selectedServerId = value;
    // update();
  }


  // get Selected Server Connection Info
  ConnectInfoDTO? get SelectedServerConnectionInfo => Defines.getConnectInfo(_selectedServerId!);



  getConnectInfo(String server_idx)
  {
    return Defines.getConnectInfo(server_idx);
  }

  ConnectInfoDTO connectInfo;


  NetController(this.connectInfo , int net_interval )
  : super(RpcClientRap<GatewayClient>(connectInfo ,clientCreator ), net_interval)
  {

    // registerSnapSuccessFullHandler(OnSnapSuccessFullHandler);

    startTask();
  }


  static GatewayClient clientCreator(ClientChannel channel)
  {
    return GatewayClient(channel);
  }


  //
  // @override
  // void onInit() {
  //   super.onInit();
  //
  //   print("init");
  //
  // }

  Future<void> connectTest() async {
    try {
      // _rpcClientRap.Connect();

      // String address = connectInfo.adress;
      // int port = connectInfo.port;

      String address = "192.168.1.72";
      int port = 50050;

      rpcClientRap?.ConnectWithConnectInfo( ConnectInfoDTO(address, port) );

      print("Connect to Server Address : $address port : $port");
      // final response = await grpcClient.stub.connect(YourConnectRequest());
      // isConnected.value = response.success;
    } catch (e) {
      print('Caught error: $e');
    }
  }

  Future<void> connectRelease() async {
    try {

      String address = "192.168.20.100";
      int port = 50050;

      rpcClientRap?.ConnectWithConnectInfo( ConnectInfoDTO(address, port) );

      // String address = connectInfo.adress;
      // int port = connectInfo.port;

      print("Connect to Server Address : $address port : $port");
      // final response = await grpcClient.stub.connect(YourConnectRequest());
      // isConnected.value = response.success;
    } catch (e) {
      print('Caught error: $e');
    }
  }


  Future<eNetworkState> serverConnect(ConnectInfoDTO connect_info_dto ) async {

    try {
      rpcClientRap?.ConnectWithConnectInfo(connect_info_dto);
      eNetworkState networkState = await pingCheck();
      return networkState;
    }
    catch (e) {
      print('Caught error: $e');
      return eNetworkState.Error;
    }
  }

  // TODO connection and try

  // 1. connection
  // 2. pingcheck
  // 3. error -> disconnection ( clear )
  // 3.5 sleep(1
  // 4 Go to 1

  // Connection -> pingCheck -> Error -> Disconnection -> Sleep(1) -> Go to Connection
  // T ConnectWithConnectInfo( ConnectInfoDTO connect_info_dto )
  // {
  //
  // }

  //1. pingCheck
  //2. Error -> Disconnection
  //3. connection
  //4. sleep(1)
  //5. Go to 1

  Future<void> pingCheckAndReconnect() async {
    try
    {
      eNetworkState networkState = await pingCheck();


      if (rpcClientRap!.IsNetworkConnected() == false)
      {
        await rpcClientRap?.DisConnect();
        // await Future.delayed(Duration(seconds: 1));
        await serverConnect(connectInfo);

      }
    } catch (e) {
      print('Caught error: $e');
    }
  }


  Future<eNetworkState> serverConnectRetry(ConnectInfoDTO connect_info_dto , {int retry_count = Defines.Infinity }) async {

    try
    {

      while ( await serverConnect(connect_info_dto) != eNetworkState.Connected )
      {

        await rpcClientRap?.DisConnect();

        print("Retry Connect to Server Address : ${connect_info_dto.adress} port : ${connect_info_dto.port}");

        await Future.delayed(Duration(seconds: 1));

        if( retry_count == Defines.Infinity )
          continue;

        if( retry_count-- == 0 )
          return eNetworkState.Error;
      }

      return eNetworkState.Connected;

    }
    catch(e)
    {
      print('Caught error: $e');
      return eNetworkState.Error;
    }


  }


  Future<void> connect() async {
    try {

      rpcClientRap?.Connect();

      String address = connectInfo.adress;
      int port = connectInfo.port;

      print("Connect to Server Address : $address port : $port");
      // final response = await grpcClient.stub.connect(YourConnectRequest());
      // isConnected.value = response.success;
    } catch (e) {
      print('Caught error: $e');
    }
  }

  Future<void> connectWithConnectInfo() async {
    try {
      rpcClientRap?.ConnectWithConnectInfo (SelectedServerConnectionInfo!);

      // final response = await grpcClient.stub.connect(YourConnectRequest());
      // isConnected.value = response.success;
    } catch (e) {
      print('Caught error: $e');
    }
  }


  Future<void> disconnect() async {
    try {

      rpcClientRap?.DisConnect();

      // final response = await grpcClient.stub.disconnect(YourDisconnectRequest());
      // isConnected.value = response.success;
      // await grpcClient.shutdown();
    } catch (e) {
      print('Caught error: $e');
    }
  }


  Future<eNetworkState> pingCheck() async {
    try
    {
      void_? rv = await rpcClientRap?.SendAsyncLocal<void_, GatewayClient>(
              (rpcClient) => rpcClient.ping(void_() , options: CallOptions(timeout: Duration(seconds: 1)))
      );
      rpcClientRap?.UpdatePingCheck(rv==null?false:true);
      // print("ping checked!!");

      if( rv == null ) {
        print("pingCheck error: response is null");
      }
      return rpcClientRap!.networkStatus;
    }
    catch (e)
    {
      // print(" EEEEEEEE NetController action================================");
      rpcClientRap?.UpdatePingCheck(false);
      print('pingCheck error: $e');
      return rpcClientRap!.networkStatus;
    }
  }


  eNetworkState? get networkStatus => rpcClientRap?.networkStatus;

  //
  //
  // @override
  // Future<bool> actionSnap(IModel? model)
  // {
  //   pingCheck();
  //   update();
  //   return Future.value(true);
  // }
  //
  // IModel? OnSnapSuccessFullHandler(IModel? model)
  // {
  //   update();
  //   return null;
  // }




  @override
  Future<void> action() async
  {
    // pingCheck();

    try {
      await pingCheckAndReconnect();
      update();
    }
    catch (e) {
      print('Net Controller Action Error error: $e');
    }
  }



}
