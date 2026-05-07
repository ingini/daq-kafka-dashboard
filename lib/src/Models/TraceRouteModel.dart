import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:dart_ping/dart_ping.dart';


class TraceRouteModel extends SensorModel {


  bool _is_success = false;

  String _ip_address = "";

  PingData? _pingData;

  TraceRouteModel(String tag , [String ip_address=""] )
      : _ip_address = ip_address , super(tag);


  PingData? get pingData => _pingData!;

  set pingData(PingData? value) {
    _pingData = value;
  }


  String? get ip => _pingData?.response?.ip;

  String  getIp() {
    return _ip_address;
  }



  int? get seq => _pingData?.response?.seq;

  Duration? get durationTime => _pingData?.response?.time;
  double get durationTimeMs => _pingData!.response!.time!.inMicroseconds!.toDouble() / 1000.0;


  double getDurationTimeMs(){

    var t = _pingData?.response?.time;

    if( t == null)
      return 0.0;

    return t.inMicroseconds!.toDouble() / 1000.0;
  }

  // String get durationTimeMsStr {
  //   return getDurationTimeMs().toStringAsFixed(2) + " ms";
  // }

  String getDurationTimeMsStr() {

    if(isSuccessFull() == false )
      return "";

    return getDurationTimeMs().toStringAsFixed(2) + " ms";

  }


  // bool get isSuccess => _is_success;


  bool isSuccessFull(){
    return _is_success;
  }

  set isSuccess(bool value) {
    _is_success = value;
  }


}


