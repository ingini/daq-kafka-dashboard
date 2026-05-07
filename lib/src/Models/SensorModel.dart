
import 'package:daq_dashboard/src/ProcessingState/ProcessingState.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/Models/GroupModel.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/TagModel.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:daq_dashboard/src/protos/daq-service.pbenum.dart';
import 'package:daq_dashboard/src/protos/daq-service.pbgrpc.dart';
import 'package:dart_ping/dart_ping.dart';

import '../protos/daq-service.pb.dart';


// TODO
//SensorModel 은 이후에
//ProcessingStateStack? _stateStack;
// 을 가지는 방법으로 바꿔야한다.
// 이를 위해
// abSensorModel 은 abTagModel + ProcessingStateStack 를 가짐
// abSensorModel 을 상속 받능 SensorModel 을 사용함
//





class SensorModel<T extends IModel> extends abTagModel {

  String? _sensor_name;


  Connection? _device_connection;
  Health? _device_health;

  Connection? _connection;
  Health? _health;


  Acquisition? _acquisition;

  ProcessingStateStack? _stateStack;

  PingData? _pingData;


  GroupModel<T> _groupModel = GroupModel<T>();


  SensorModel(String tag)
      : super(tag)
  {
    _sensor_name = MetaPropertyManager().getSensorName(tag)!;
  }

  String get sensor_name => _sensor_name!;


  void setPingData(PingData pingdata)
  {
    _pingData = pingdata;
  }

  PingData? getPingData()
  {
    return _pingData;
  }

  bool IsPingSuccess()
  {
    return _pingData?.response?.time != null ? true : false;
  }

  //stateStack
  ProcessingStateStack? get stateStack => _stateStack;
  // set stateStack(ProcessingStateStack? value) {
  //   _stateStack = value;
  // }

  SensorModel getElementModel(String tag_name)
  {
    return _groupModel.getModel(tag_name) as SensorModel;
  }


  ProcessingState? getProcessingstate(eProcessingState processingState ) {
    return _stateStack?.getProcessingState(processingState);
  }

  void setProcessingStateResult(eProcessingState processingState , bool result )
  {
    getProcessingstate(processingState)?.setSuccess(result);
  }


  GroupModel<T> get groupModel => _groupModel;


  bool IsStateSuccess( eProcessingState processingState )
  {
    return _stateStack?.isSuccess(processingState) ?? false;
  }


  bool IsAcquiring()
  {
    if(IsStateSuccess(eProcessingState.Acquiring))
    {
      if( _acquisition?.state == Acquisition_State.ACQUIRING)
      {
        return true;
      }
    }

    return false;
  }

  String GetAcquiringStr()
  {
    if( IsAcquiring() )
    {
      return "Acquiring";
    }
    else
    {
      return "Not Acquiring";
    }
    //
    // if(IsStateSuccess(eProcessingState.Acquiring))
    // {
    //   if( _acquisition?.state == Acquisition_State.ACQUIRING)
    //   {
    //     return true;
    //   }
    // }
    //
    // return false;
  }

  Connection? get device_connection => _device_connection;
  set device_connection(Connection? value) {
    _device_connection = value;
  }

  Connection_State? get device_connection_state => _device_connection?.state;

  Health? get device_health => _device_health;
  set device_health(Health? value) {
    _device_health = value;
  }

  Health_Status? get device_health_state => _device_health?.status;


  //setter getter
  Connection? get connection => _connection;
  set connection(Connection? value) {
    _connection = value;
  }

  Connection_State? get connection_state => _connection?.state;

  Health? get health => _health;
  set health(Health? value) {
    _health = value;
  }

  Health_Status? get health_state => _health?.status;

  Acquisition? get acquisition => _acquisition;
  set acquisition(Acquisition? value) {
    _acquisition = value;
  }

  Acquisition_State? get acquisition_state => _acquisition?.state;

  @override
  void setStateStack(ProcessingStateStack stateStack) {

    _stateStack = stateStack;

  }
}
