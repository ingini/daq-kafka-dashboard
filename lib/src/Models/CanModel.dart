import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/Models/TagModel.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';



class CanModel extends SensorModel {


  int? _bytes_per_sec;

  CanModel(super.tag);

  //getters
  int? get bytes_per_sec => _bytes_per_sec;
  //setter
  set bytes_per_sec(int? value) {
    _bytes_per_sec = value;
  }


}