import 'package:daq_dashboard/src/State/RecodingState.dart';
import 'package:daq_dashboard/src/dataObjects/IData.dart';
import 'package:get/get.dart';

abstract class IStateVariable implements IData{

}



class VoiceRecordingStateVariable implements IStateVariable
{

  Rx<E_RecordingState?> _recordingState = Rx<E_RecordingState?>(null);
  var _filePath = ''.obs;
  var _recordedFileName = ''.obs;

  //getter setter
  String? get filePath => _filePath.value;
  set filePath(String? value) => _filePath.value = value!;

  //getter setter
  String? get recordedFileName => _recordedFileName.value;
  set recordedFileName(String? value) => _recordedFileName.value = value!;


  //getter setter
  E_RecordingState? get recordingState => _recordingState.value;
  set recordingState(E_RecordingState? value) => _recordingState.value = value;

}



