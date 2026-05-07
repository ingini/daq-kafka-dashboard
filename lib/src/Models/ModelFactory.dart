
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';

class ModelFactory {

  static T Create<T extends IModel >( T model ) {
    return model;
  }

  static T? DefaultFactory<T extends IModel >(T model) {
    return model;
  }


  static R OnCreate<String ,R extends IModel >( Func1<String,R> onModelCreate ,String tag_name ) {
    return onModelCreate.Invoke(tag_name);
  }


}