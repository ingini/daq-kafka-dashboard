

import 'package:daq_dashboard/src/dataObjects/IData.dart';

abstract class IDTO implements IData
{

}




class VoiceTagDto extends IDTO {

  final DateTime timestamp;
  final String   recordFileFullPath;

  VoiceTagDto({
    DateTime? timestamp,
    required this.recordFileFullPath
  }) : timestamp = timestamp ?? DateTime.now();

}

