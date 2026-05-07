
import 'package:daq_dashboard/src/Handler/HandlerType.dart';
import 'package:daq_dashboard/src/Handler/abSensorHandler.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';



class UnActiveHandler extends abSensorHandler {

  UnActiveHandler( Action1<eHandlerType> handle)
      : super( eHandlerType.UnActive, handle);

  //
  // UnActiveHandler(void Function(eHandlerType) handle)
  //     : super( eHandlerType.UnActive, handle);
}



class NetworkUnConnectedHandler extends abSensorHandler {

  NetworkUnConnectedHandler(Action1<eHandlerType> handle)
      : super( eHandlerType.NetworkUnConnected , handle);

  // NetworkUnConnectedHandler(void Function(eHandlerType) handle)
  //     : super( eHandlerType.NetworkUnConnected , handle);
}


class SensorUnConnectedHandler extends abSensorHandler {

  SensorUnConnectedHandler(Action1<eHandlerType> handle)
      : super( eHandlerType.SensorUnConnected , handle);
}


class SensorUnHealthyHandler extends abSensorHandler {

  SensorUnHealthyHandler(Action1<eHandlerType> handle)
      : super( eHandlerType.SensorUnHealthy , handle);
}


class ExceptionHandler extends abSensorHandler {

  ExceptionHandler(Action1<eHandlerType> handle)
      : super( eHandlerType.Exception , handle);
}

class SnapSuccessFullHandler extends abSensorHandler {

  SnapSuccessFullHandler(Action2<eHandlerType , IModel> handle)
      : super(eHandlerType.SnapSuccess  ,handle);
}


class SnapFaiHandler extends abSensorHandler {

  SnapFaiHandler(Action1<eHandlerType> handle)
      : super(eHandlerType.SnapFail  ,handle);
}

