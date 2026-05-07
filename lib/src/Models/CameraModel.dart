
import 'package:daq_dashboard/src/ProcessingState/ProcessingState.dart';
import 'package:daq_dashboard/src/dtos/ConnectionDTO.dart';
import 'package:daq_dashboard/src/dtos/RowImageDTO.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/MovieClipModel.dart';
import 'package:daq_dashboard/src/Models/TagModel.dart';
import 'package:daq_dashboard/src/protos/daq-service.pbenum.dart';
import 'package:daq_dashboard/src/protos/daq-service.pbgrpc.dart';

import '../protos/daq-service.pb.dart';


class CameraModel extends MovieClipModel {


  CameraModel(String tag)
      : super(tag)
  {
      // print("    ccccccaaaaaaaammmmm");
  }


}


