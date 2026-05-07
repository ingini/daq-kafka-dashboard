
import 'package:daq_dashboard/src/Handler/HandlerType.dart';
import 'package:daq_dashboard/src/Handler/IHandler.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';

abstract class abSensorHandler implements IHandler {
  // void handle();

  // final void Function(eHandlerType) handle;

  final IDelegate handler;

  final eHandlerType handler_type;

  abSensorHandler(this.handler_type, this.handler);

  IDelegate getHandler() {
    return handler;
  }

  //
  //
  // void Invork(){
  //   handle(this.handler_type);
  // }

}