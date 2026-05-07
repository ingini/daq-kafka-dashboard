




import 'dart:collection';

import 'package:daq_dashboard/src/container/CollectionIterator.dart';
import 'package:daq_dashboard/src/container/ICollection.dart';
import 'package:daq_dashboard/src/dataObjects/idto.dart';

class DtoQueue<T extends IDTO > extends ICollection<T>{

  Queue<T> _queue = Queue<T>();


  void add(T element)
  {
    _queue.add(element);
  }

  T? pop() {
    if (_queue.isNotEmpty) {
      return _queue.removeFirst();
    }
    return null;
  }

  @override
  void clear() {
    _queue.clear();
  }

  @override
  ICollectionItorator<T> getCollectionItorator() {
    return CollectionItorator(_queue as ICollection<T>);
  }

  @override
  int getLength() {
    return _queue.length;
  }

  @override
  T getValue(int index) {
    return _queue.elementAt(index);
  }

  @override
  bool isEmpty() {
    return _queue.isEmpty;
  }

}


class LastestDtoQueue<T extends IDTO> extends DtoQueue<T>
{
  @override
  void add(T element)
  {
    if( _queue.isNotEmpty )
    {
      _queue.clear();
    }
    _queue.add(element);
  }

  @override
  T? pop()
  {
    if (_queue.isNotEmpty) {
      return _queue.removeFirst();
    }
    return null;
  }

  @override
  T? peek()
  {
    if (_queue.isNotEmpty) {
      return _queue.first;
    }
    return null;
  }
}

