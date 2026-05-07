
import 'dart:async';

import 'package:daq_dashboard/src/Controllers/NotificationController.dart';
import 'package:daq_dashboard/src/Controllers/RpcRapperController.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/ModelQueue.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';

abstract class TaskController extends RpcRapperController {

  late Timer _timer;
  late int _millisecond;
  NotificationController? _notificationController;



  TaskController(RpcClientRap<GatewayClient>? rpcClientRap , int millisecond)
      : _millisecond = millisecond, super(rpcClientRap)
  {
    setNotificationController();
  }

  //getter
  NotificationController get notificationController => _notificationController!;


  @override
  void setNotificationController()
  {
    _notificationController =  NotificationController.getController();
  }




  bool _isActionRunning = false;

  void startTask() {


    _timer = Timer.periodic(Duration(milliseconds: _millisecond), (timer) async {
      if (_isActionRunning) {
        return;
      }
      _isActionRunning = true;

      try {
        await action();
      }
      catch (e)
      {
        print("TaskController startTask error : $e");
      }
      finally {
        _isActionRunning = false;
      }

      //
      // try {
      //   if (!isActionRunning) {
      //     isActionRunning = true;
      //     await action();
      //     isActionRunning = false;
      //   }
      // }
      // catch (e)
      // {
      //   print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwTaskController startTask error : $e");
      //   print("TaskController startTask error : $e");
      // }
      // finally {
      //   isActionRunning = false;//print("TaskController startTask finally");
      // }

    });
  }
  //반드시 재정의 하게

  @override
  Future<void> action() async
  {
    print("TaskController action");
  }

  void stopTask() {
    if( _timer.isActive )
      _timer.cancel();
  }

}
