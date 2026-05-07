


import 'package:daq_dashboard/src/dataObjects/IData.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';

import '../deleGate/DeleGate.dart';


//TODO 이부분을 좀 보자
//일단은 Controller 통신의 결과에 따라서 Model 을 셋팅한다.,
//이거를 자동으로 해야 한다.
//이부분을 좀 더 보자



//여기에 인터페이스 함수를 좀 만들어 주고

abstract class EventTaskResponse<T> implements IData {

    bool _isSuccess;

    EventTaskResponse(this._isSuccess);

    bool get isSuccess => _isSuccess;

    set isSuccess(bool value) {
      _isSuccess = value;
    }

    T? getPacketData();
}

class EventTaskResponseResult<T> extends EventTaskResponse<T> {

  T? _packet_data;

  EventTaskResponseResult([ bool isSuccess = false , T? packet_data])
      : super(isSuccess){
    _packet_data = packet_data;
  }

  T? get packet_data => _packet_data;

  T? getPacketData() {
    return _packet_data;
  }

}

//
// class EventTaskResponseSensorConnected extends EventTaskResponse {
//
//   Connection? _connection;
//
//   EventTaskResponseSensorConnected([ bool isSuccess = false , Connection? connection])
//       : super(isSuccess){
//     _connection = connection;
//   }
// }
//
// class EventTaskResponseSensorHealthy extends EventTaskResponse {
//
//   Health? _health;
//
//   EventTaskResponseSensorHealthy([ bool isSuccess = false , Health? health])
//       : super(isSuccess){
//     _health = health;
//   }
// }
//
// class EventTaskResponseSensorAcquiring extends EventTaskResponse {
//
//   Acquisition? _acquisition;
//
//   EventTaskResponseSensorAcquiring([ bool isSuccess = false , Acquisition? acquisition])
//       : super(isSuccess){
//     _acquisition = acquisition;
//   }
// }
//
// class EventTaskResponseSnap extends EventTaskResponse {
//
//   SensorSnapshot? _sensorSnapshot;
//
//   EventTaskResponseSnap([ bool isSuccess = false , SensorSnapshot? sensorSnapshot])
//       : super(isSuccess){
//     _sensorSnapshot = sensorSnapshot;
//   }
// }


class EventTaskResult extends EventTaskResponse {

  IModel? _model;

  EventTaskResult([ bool isSuccess = false])
      : super(isSuccess);


  Action? resultsCallBack;

  Action? get getResultsCallBack => resultsCallBack;

  set setResultsCallBack(Action? value) {
    resultsCallBack = value;
  }


  IModel? get model => _model;

  set model(IModel? value) {
    _model = value;
  }

  @override
  getPacketData() {
    // TODO: implement getPacketData
    throw UnimplementedError();
  }



}
