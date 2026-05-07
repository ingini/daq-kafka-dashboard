import 'dart:ui' as ui;

import 'package:daq_dashboard/src/dataObjects/idto.dart';
import 'package:daq_dashboard/src/utils/QueuePool.dart';

class RowImageDTO implements IDTO {
  final ui.Image _rowIamge;

  String? _name;
  // String? _sequence;


  RowImageDTO(this._rowIamge , this._name )
  {
    // _sequence = DateTime.now().millisecondsSinceEpoch.toString();
  }

  ui.Image get rowIamge => _rowIamge;
  String? get name => _name;

  String toString(){

    String sb = "";
    sb += "nm : $_name \n ";
    sb += "si : ${_rowIamge.width}\n";

    return sb;
  }

}

class RowImageDTOPool<T extends IDTO > extends StackPool<T> {
  RowImageDTOPool({int queue_size = 10}) : super(size: queue_size);
}


