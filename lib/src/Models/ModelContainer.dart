


import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/ProcessingState/ProcessingState.dart';

class ModelContainer<T extends IModel > implements IModel{

  Map<String , T > _modelContainer = {};


  ModelContainer();

  Map<String , T > get getContainer => _modelContainer;

  void addModel( String key , T model) {
    _modelContainer[key] = model;
  }

  T? getModel( String key ) {
    return _modelContainer[key];
  }

  void removeModel( String key ) {
    _modelContainer.remove(key);
  }

  void clear() {
    _modelContainer.clear();
  }

  @override
  void setStateStack(ProcessingStateStack stateStack) {
    // TODO: implement setStateStack
  }
}