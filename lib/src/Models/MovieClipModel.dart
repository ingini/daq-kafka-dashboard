
import 'package:daq_dashboard/src/dtos/RowImageDTO.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';



class MovieClipModel extends SensorModel {
  RowImageDTO? _row_image;

  MovieClipModel(String tag)
      : super(tag);

  RowImageDTO? get row_image => _row_image;
  set row_image(RowImageDTO? value) {
    _row_image = value;
  }

}


