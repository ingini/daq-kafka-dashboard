import 'package:daq_dashboard/src/Configure/configUtil.dart';
import 'package:daq_dashboard/src/dtos/ConnectInfoDTO.dart';
import 'package:daq_dashboard/src/meta/Modes.dart';

class AppManager {
  // Private constructor
  AppManager._internal();

  // The single instance of the class
  static final AppManager _instance = AppManager._internal();

  // Public factory constructor
  factory AppManager() {
    return _instance;
  }

  // Static method to get the instance
  static AppManager get instance => _instance;


  static ConfigUtil? _configUtil;

  static DaqEdgeDTO? _daqEdgeDTO;

  //getter
  ConfigUtil? get configUtil => _configUtil;

  DaqEdgeDTO? get daqEdgeDTO => _daqEdgeDTO;


  void Initialize() {
    _configUtil = ConfigUtil.instance;
  }

  Future<void> LoadConfig() async {

    await _configUtil?.config;
    _daqEdgeDTO = (await _configUtil?.getDaqEdgeDto()) as DaqEdgeDTO?;

  }

  Future<eRunMode> getRunModeAsync() async {
    String runMode = await _configUtil?.getValue(eConfigKey.run_mode) ;
    eRunMode e_runMode =  eRunModeExtension.fromString(runMode) ;

    return e_runMode;
  }

  eRunMode getRunMode()  {
    String runMode = _configUtil?.getValueImmediately(eConfigKey.run_mode) ;
    eRunMode e_runMode =  eRunModeExtension.fromString(runMode) ;

    return e_runMode;
  }

  Future<bool> isDebugAsync() async {
    return await getRunModeAsync() == eRunMode.Debug;
  }


  bool isDebug() {
    return getRunMode() == eRunMode.Debug;
  }


  Future<int> getInterval() async {
    return await _configUtil!.getInterval();
  }


  bool daqEdgeIsActive(){

    if( _daqEdgeDTO == null )
      return false;

    return _daqEdgeDTO!.active;


  }




}

//
// void main() {
//   // Getting the singleton instance of AppManager
//
//   // AppManager.instance.printAppState();
//   // AppManager.instance.printAppState();
//   // AppManager.instance.printAppState();
//   // AppManager.instance.printAppState();
//
//
//
//
//   // var manager1 = AppManager();
//   // manager1.appState = 'Running';
//   //
//   // // Getting the singleton instance again
//   // var manager2 = AppManager();
//   // manager2.printAppState(); // Outputs: App State: Running
//   //
//   // // Checking if both instances are the same
//   // print(manager1 == manager2); // Outputs: true
// }