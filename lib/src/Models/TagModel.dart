


import 'package:daq_dashboard/src/Models/IModel.dart';

abstract class abTagModel extends IModel {

  String _tag;
  abTagModel(this._tag);

  String get tag => _tag;


  //
  // static T Factory<T extends IModel >( T model ) {
  //   return model;
  // }
  //
  // static T? DefaultFactory<T extends IModel >(String tag) {
  //   return null;
  // }



}
