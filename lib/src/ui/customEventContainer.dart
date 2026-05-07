




import 'dart:collection';

import 'package:daq_dashboard/src/container/CollectionIterator.dart';
import 'package:daq_dashboard/src/container/ICollection.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter/widgets.dart';

class customEventContainer extends ICollection<GlobalKey<State>> {

  // Queue<GlobalKey<State<TaggingStatefulWidget>>> _queue = Queue<GlobalKey<State<TaggingStatefulWidget>>>();
  Map< eWidgetID , GlobalKey<TaggingWidgetState>> _container = Map<eWidgetID , GlobalKey<TaggingWidgetState>>();


  //getter
  Map< eWidgetID , GlobalKey<TaggingWidgetState>> get container => _container;



  @override
  void clear() {
    _container.clear();
  }

  void append(eWidgetID  widgetid  , GlobalKey<TaggingWidgetState> key) {
    _container[widgetid] = key;
  }



  @override
  ICollectionItorator<GlobalKey<TaggingWidgetState> > getCollectionItorator() {

    // for( var key in _queue){
    //   key.currentState!.onButtonDown();
    //   print(key);
    // }

    // return _queue.iterator;
    // TODO: implement getLength
    throw UnimplementedError();
  }

  @override
  int getLength() {
    return _container.length;
  }

  @override
  GlobalKey<State<StatefulWidget>> getValue(int index) {
    return _container.values.elementAt(index);
  }

  GlobalKey<State<StatefulWidget>> getValueFromID(eWidgetID widget_id) {
    return _container[widget_id]!;
  }

  @override
  bool isEmpty() {
    return _container.isEmpty;
  }



}

