



import 'package:daq_dashboard/src/container/ICollection.dart';

abstract class ICollectionAsync<T> extends ICollection<T>   {

  // int getLength();
  // bool isEmpty();
  // T getValue(int index);
  // void clear();
  // ICollectionItorator<T> getCollectionItorator();


  Future<int> getLengthAsync() ;
  Future<bool> isEmptyAsync();
  Future<T> getValueAsync(int index);
  Future<void> clearAsync();

}