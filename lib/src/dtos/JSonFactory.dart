


import 'package:daq_dashboard/src/dataObjects/IJSon.dart';

class JSonFactory {

  static IJSon fromJsonFactory(Function( String)? act, String json_string)
  {
    IJSon result;
    result = act!( json_string ) ;

    return result;
  }

  //
  static IJSon fromJsonTypeFactory<T>(Function(T, String)? act, T _type , String _json_string) {
    IJSon result;
    result = act!(_type, _json_string);

    return result;
  }


  //
  static IJSon fromJsonObjectTypeFactory<T>(Function(T, dynamic)? act, T _type , dynamic _json_object) {
    IJSon result;
    result = act!(_type, _json_object);

    return result;
  }

}