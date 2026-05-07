



import 'package:daq_dashboard/src/container/ICollection.dart';


abstract class ICollectionItorator<T>{

  bool hasNext();
  T? next();

}

class CollectionItorator<T> implements ICollectionItorator<T>{


  late ICollection<T> _collection;


  int cursor=0;

  CollectionItorator(ICollection<T> collection){
    _collection = collection;
  }

  // c : 0     l 1
  // c 0  l2
  // 1
  bool hasNext(){
    if(cursor < _collection.getLength() )
      return true;
    else
      return false;
  }

  T? next(){
    if(hasNext()) {
      // print("cursor : $cursor");
      return _collection.getValue(cursor++);
    }
    else
      return null;
  }


}