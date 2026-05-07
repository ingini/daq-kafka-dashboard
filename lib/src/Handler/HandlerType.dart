


enum eHandlerType
{
  None,
  UnActive ,
  NetworkUnConnected,
  SensorUnConnected,
  SensorUnHealthy,
  Exception,
  SnapSuccess,
  SnapFail;


  String get str => this.toString().split('.').last;

  static eHandlerType getHandlerType(String str) {

    for (eHandlerType type in eHandlerType.values)
    {
      if (type.str.toLowerCase() == str.toLowerCase())
      {
        return type;
      }
    }
    return eHandlerType.None;
  }

}
//
// void  main()
// {
//   print(eHandlerType.SnapSuccess);
//   print(eHandlerType.SnapSuccess.str);
//   print(eHandlerType.getHandlerType("SnapSuccess").str);
// }
//
