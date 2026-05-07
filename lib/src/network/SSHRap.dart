import 'dart:convert';

import 'package:daq_dashboard/src/Controllers/NotificationController.dart';
import 'package:daq_dashboard/src/dtos/ConnectInfoDTO.dart';
import 'package:daq_dashboard/src/network/networkConts.dart';
import 'package:dartssh2/dartssh2.dart';


class SSHRap {

  eNetworkState _networkStatus = eNetworkState.None;
  late SSHClient _client;

  DaqEdgeDTO? _sshConnectDTO;

  late NotificationController _notificationController;


  SSHRap( DaqEdgeDTO sshConnectDTO )
  {
    _sshConnectDTO = sshConnectDTO;

    // _notificationController = NotificationController.getController();
  }


  Future<void> connect() async {
    try {

      // _sshConnectDTO = sshConnectDTO;

      SSHSocket socket = await SSHSocket.connect(_sshConnectDTO!.adress, _sshConnectDTO!.port);
      _client = SSHClient(socket, username: _sshConnectDTO!.user_name, onPasswordRequest: () => _sshConnectDTO!.password);
      _networkStatus = eNetworkState.Connected;
    }
    catch (e) {
      print(e);
      _networkStatus = eNetworkState.Error;
    }
  }

  Future<void> connectCheckAndReConnect() async {

    bool isconnected = await connectCheck();

    if ( !isconnected )
    {
      await disconnect();
      await connect();
    }

  }

  Future<bool> connectCheck() async {

    try
    {
      final response = await _client.run("echo 'connected'");
      final tmp = utf8.decode(response);

      if (tmp.trim() == 'connected')
      {
        // print('SSH connection established.');
        _networkStatus = eNetworkState.Connected;
        return true;
      }
      _networkStatus = eNetworkState.Error;
      print('Failed to establish SSH connection.');

      // _notificationController.addNotification("Failed to SSH connection.");

      return false;
    }
    catch(e)
    {
      _networkStatus = eNetworkState.Error;
      print('excepted to establish SSH connection.');

      // _notificationController.addNotification("excepted to SSH connection. [ ${e.toString()} ] ");


      return false;
    }
  }

  Future<String> executeCommand(String cmd) async {
    try
    {

      if (_networkStatus != eNetworkState.Connected)
      {
        throw Exception('SSH connection not established.');
      }

      final command = await _client.run(cmd);
      // final tmp = utf8.decode(command);
      // print("oooooo${cmd}");
      return utf8.decode(command);
    }
    catch(e)
    {
      return 'Error: ${e.toString()}';
    }
  }

  Future<void> disconnect() async {
    _networkStatus = eNetworkState.None;
    try
    {
      _client.close();
    }
    catch (e)
    {
      print(e);
    }

  }

}
