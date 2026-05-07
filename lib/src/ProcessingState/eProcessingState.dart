
enum eProcessingState
{
  None,

  UnDeviceConnected,
  DeviceConnected,

  UnDeviceHealthy,
  DeviceHealthy,



  UnControlActive,
  ControlActive ,

  UnNetworkConnected,
  NetworkConnected,

  UnSensorConnected,
  SensorConnected,



  UnSensorHealthy,
  SensorHealthy,


  UnUserCustom,
  UserCustom,


  UnAcquiring,
  Acquiring,

  UnSnap,
  Snap;


  String get str => this.toString().split('.').last;

  static eProcessingState getProcessingState(String str) {

    for (eProcessingState type in eProcessingState.values)
    {
      if (type.str.toLowerCase() == str.toLowerCase())
      {
        return type;
      }
    }
    return eProcessingState.None;
  }

  static int getIndex(eProcessingState state)
  {
    return state.index;
  }

  static eProcessingState getState(int index) {
    return eProcessingState.values[index];
  }

}



void  main()
{
  print(eProcessingState.ControlActive);
  print(eProcessingState.ControlActive.str);
  print(eProcessingState.getProcessingState("ControlActive").str);

  int ind= eProcessingState.getIndex(eProcessingState.ControlActive);
  print("ind : $ind");
  print(eProcessingState.getState(ind));
  print(eProcessingState.getState(ind - 1));

}
