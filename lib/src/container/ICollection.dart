



import 'package:daq_dashboard/src/container/CollectionIterator.dart';

abstract class ICollection<T> {

  int getLength();

  bool isEmpty();


  T getValue(int index);


  void clear();



  ICollectionItorator<T> getCollectionItorator();







}




