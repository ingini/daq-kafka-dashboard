

import 'dart:async';

import 'package:daq_dashboard/src/dtos/ConnectInfoDTO.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart';


import 'networkConts.dart';



typedef ClientCreator<T> = T Function(ClientChannel channel);

class RpcClientRap<T extends Client > {

//class RpcClient<T extends Client > {

  eNetworkState _networkStatus = eNetworkState.None;
  T? _grpcClient;

  // String address = "";
  // int    port = 0;

  ConnectInfoDTO? _connectInfodto;

  ConnectInfoDTO? get connectInfodto => _connectInfodto;

  set connectInfodto(ConnectInfoDTO? value) {
    _connectInfodto = value;
  }





  ClientCreator<T>? _creator; // 클라이언트 생성자

  set creator ( ClientCreator<T> creator )
  {
    this._creator = creator;
  }

  T? get rpcClient { return _grpcClient; }

  ClientChannel? _channel;

  ClientChannel? get _getChannel
  {
    return ClientChannel(
      _connectInfodto!.adress,
      port: _connectInfodto!.port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  eNetworkState get networkStatus { return _networkStatus; }

  RpcClientRap( this._connectInfodto ,this._creator);

  static bool IsAbleNetComunication(RpcClientRap client_rep)
  {

    if( client_rep == null )
      return false;


    if ( client_rep.networkStatus != eNetworkState.Connected )
      return false;

    if ( client_rep.rpcClient == null )
      return false;


    return true;

  }


  T ConnectWithConnectInfo( ConnectInfoDTO connect_info_dto )
  {

    _connectInfodto = connect_info_dto;

    if ( _networkStatus == eNetworkState.Connected )
      return _grpcClient!;

    if ( _channel == null )
    {
      _channel = _getChannel;
    }

    _grpcClient = _creator!(_channel!);
    if ( _grpcClient != null )
    {
      // _channel.getConnection()
      // _grpcClient.
      _networkStatus = eNetworkState.Connected;
    }
    return _grpcClient!;

  }

  T Connect()
  {
    if ( _networkStatus == eNetworkState.Connected )
      return _grpcClient!;

    if ( _channel == null )
    {
      _channel = _getChannel;
    }

    _grpcClient = _creator!(_channel!);
    if ( _grpcClient != null )
    {
      // _channel.getConnection()
      // _grpcClient.
      _networkStatus = eNetworkState.Connected;
    }
    return _grpcClient!;

  }
  //
  // static Future<K?> SendAsync<K extends GeneratedMessage>(RpcClientRap clientRep, Future<K> Function(T) action) async {
  //   try {
  //     if (!IsAbleNetComunication(clientRep)) {
  //       return null;
  //     }
  //     return await action(clientRep.rpcClient!);
  //   } catch (e) {
  //     print("Error ==> [ $e ] <===== ");
  //     throw e;
  //   }
  // }


  void UpdatePingCheck(bool is_ping)
  {
    if ( is_ping )
    {
      _networkStatus = eNetworkState.Connected;
    }
    else
    {
      _networkStatus = eNetworkState.None;
    }
  }

  bool IsNetworkConnected()
  {
    if ( _networkStatus == eNetworkState.Connected )
    {
      return true;
    }

    return false;

  }


  Future<K?> SendAsyncLocal<K extends GeneratedMessage , T extends Client>
      (  Future<K> Function(T rpc_client) action ) async
  {
    try
    {
      if ( !RpcClientRap.IsAbleNetComunication(this)  )
        return null;

      return await action(rpcClient! as T );
    }
    catch (e)
    {
      print("Error ==> [ $e ] <===== ");
      throw e;
    }
  }

  static  Future<K?> SendAsync<K extends GeneratedMessage , T extends Client>
      ( RpcClientRap clientRep ,  Future<K> Function(T rpcClient) action ) async
  {
    try
    {
      // if ( clientRep.networkStatus != eNetworkState.Connected )
      //   return null;
      if ( !IsAbleNetComunication(clientRep)  )
        return null;

      return await action(clientRep.rpcClient! as T );
    }
    catch (e)
    {
      print("Error ==> [ $e ] <===== ");
      throw e;
    }
  }
  //
  // static  Future<GeneratedMessage?> SendAsync( RpcClientRap clientRep ,  Future<GeneratedMessage?> Function() action ) async
  // // static  Future<GeneratedMessage?> SendAsync( RpcClientRap clientRep ,  Future<GeneratedMessage?> Function() action ) async
  // {
  //   try
  //   {
  //     // if ( clientRep.networkStatus != eNetworkState.Connected )
  //     //   return null;
  //
  //     if ( !IsAbleNetComunication(clientRep)  )
  //       return null;
  //
  //     return await action();
  //   }
  //   catch (e)
  //   {
  //     print("Error ==> [ $e ] <===== ");
  //     throw e;
  //   }
  //
  // }


  Future<void> DisConnect() async
  {
    try
    {
      _networkStatus = eNetworkState.None;

      if (_channel != null) {
        await _channel!.shutdown().timeout(Duration(seconds:1) , onTimeout: () {

          print('Channel shutdown timed out.');
          throw TimeoutException('Channel shutdown timed out');

        });
        _channel = null;
      }

      if (_grpcClient == null) {
        return;
      }
      _grpcClient = null; // 참조 제거
    }
    catch (e)
    {
      _networkStatus = eNetworkState.None;
      _channel = null;
      _grpcClient = null; // 참조 제거
      throw e;
    }
  }

}