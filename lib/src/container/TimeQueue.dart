
import 'package:daq_dashboard/src/container/CollectionIterator.dart';
import 'package:daq_dashboard/src/container/ICollection.dart';
import 'package:daq_dashboard/src/dataObjects/idto.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';





class TimeDataElements<T> extends IDTO {

  T _object;
  var startTime = DateTime.now();

  TimeDataElements( T object ) : _object = object;

  T get object => _object;

}

class TimeQueue<T> extends ICollection {

  List<TimeDataElements<T>> _queue = [];

  Func2<T,T,bool>? compareFunc;
  final double lifeTime;

  TimeQueue({this.lifeTime = 3.0, this.compareFunc })
  {
  }


  void setCompareFunc( Func2<T,T,bool> compareFunc ) {
    this.compareFunc = compareFunc;
  }

  void add(T element)
  {
    if (compareFunc != null)
    {
      for (var existingElement in _queue)
      {
        if (compareFunc!.Invoke(existingElement.object, element)) {
          print('Duplicate element found');
          return;
        }
      }
      _queue.add(TimeDataElements(element));
    }
  }

  bool isContain(T element)
  {
    if (compareFunc == null)
      return false;

    for (var existingElement in _queue)
    {
      if (compareFunc!.Invoke(existingElement.object, element)) {
        return true;
      }
    }

    return false;
  }

  void updateQueue() {
    var currentTime = DateTime.now();
    _queue.removeWhere((element) =>
    currentTime.difference(element.startTime).inSeconds > lifeTime);
  }

  // void updateQueue()
  // {
  //   var currentTime = DateTime.now();
  //   for (var element in _queue)
  //   {
  //     if (currentTime.difference(element.startTime).inSeconds > lifeTime)
  //     {
  //       _queue.remove(element);
  //     }
  //   }
  // }


  @override
  void clear() {
    _queue.clear();
  }

  @override
  ICollectionItorator getCollectionItorator() {
    return CollectionItorator(this);
  }

  @override
  int getLength() {
    return _queue.length;

  }

  @override
  getValue(int index) {
    return _queue[index];

  }

  @override
  bool isEmpty() {
    return _queue.isEmpty;
  }

}





void main() {

  print("TimeQueue");


  TimeQueue<String> timeQueue = TimeQueue<String>();

  timeQueue.setCompareFunc(
      Func2 (
              ( src_elements , dest_elements ) {
                if(src_elements.compareTo(dest_elements) == 0)
                  return true;
                else
                  return false;
              }
      )
  );

  timeQueue.add("Hello");


}


