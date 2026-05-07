import 'package:daq_dashboard/src/Controllers/TaskController.dart';
import 'package:daq_dashboard/src/dtos/ConnectInfoDTO.dart';
import 'package:daq_dashboard/src/network/SSHRap.dart';

class SSHController extends TaskController {

  late SSHRap? _sshRap;
  SSHRap? get sshRap => _sshRap;

  final DaqEdgeDTO daqEdgeDTO;


  SSHController( this.daqEdgeDTO , super.rpcClientRap, super.millisecond)
  {
    _sshRap = SSHRap(daqEdgeDTO);
    startTask();
  }

  Future<void> Connect() async
  {
    try {
      await _sshRap?.connect();
      print('SSHController Connect');
    }
    catch (e) {
      print('SSHController Connect Error error: $e');
    }
  }


  @override
  Future<void> action() async
  {
    // pingCheck();
    try {

      await _sshRap?.connectCheckAndReConnect();

      // await pingCheckAndReconnect();
      // update();
      // print('SSHController  Action');

    }
    catch (e) {
      print('SSHController Action Error error: $e');
    }
  }


}


