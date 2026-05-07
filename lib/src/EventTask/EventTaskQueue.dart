
import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';
import 'package:daq_dashboard/src/ProcessingState/ProcessingState.dart';
import 'package:daq_dashboard/src/container/CollectionIterator.dart';
import 'package:daq_dashboard/src/container/ICollection.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';



class EventTaskQueue<
T extends Func<Future<EventTaskResponse>> ,
S extends Action1Async<EventTaskResponse> ,
F extends Action1Async<EventTaskResponse>
> implements ICollection<EventTask<T,S,F>> {


  List<EventTask<T,S,F>> _queue = [];

  ProcessingStateStack _processingStateStack;

  SensorController _sensorController;

  SensorController get sensorController => _sensorController;


  ProcessingStateStack get processingStateStack => _processingStateStack;



  EventTaskQueue(ProcessingStateStack processingStateStack,SensorController sensorController)
  : _processingStateStack = processingStateStack , _sensorController = sensorController
  {
    // queue = {};
  }

  void init(){
    _queue = [];
    _processingStateStack.clear();
  }

  void push( EventTask<T,S,F> _task ) {
    _queue.add(_task);

    _processingStateStack.push(ProcessingState(_task.eprocessingState));

    // _processingStateStack.push(_task.processingState);
  }



  EventTask<T,S,F> getValue( int _index ) {
    return _queue[_index];
  }

  ICollectionItorator<EventTask<T,S,F>> getCollectionItorator()
  {
    return CollectionItorator(this);
  }

  EventTask peek( int _index ) {
    return _queue[_index];
  }

  bool isContain( EventTask _task ) {
    return _queue.contains(_task);
  }

  void clear() {
    _queue.clear();
  }

  void remove( EventTask _task ) {
    _queue.remove(_task);
  }

  void removeAt( int _index ) {
    _queue.removeAt(_index);
  }

  void removeLast() {
    _queue.removeLast();
  }

  void removeFirst() {
    _queue.removeAt(0);
  }

  int getLength() {
    return _queue.length;
  }

  bool isEmpty() {
    return _queue.isEmpty;
  }

  bool isNotEmpty() {
    return _queue.isNotEmpty;
  }

  List<EventTask<T,S,F>> getQueue() {
    return _queue;
  }



  Future<bool> iterator() async {
    for (EventTask<T,S,F> event_task in _queue) {
      EventTaskResponse re = await event_task.Invoke();

      if( re.isSuccess == false )
        return false;
      //
      // if(item.Invoke() == false)
      //   break;
    }

    return true;
  }

  Future<bool> iteratorAndResponse() async {

    // _processingStateStack.resetAll();

    if( _queue.length <= 0 )
      return true;

    _processingStateStack = _processingStateStack.deepCopy();

    _sensorController.ResetParamModel(_processingStateStack);


    for (EventTask<T,S,F> event_task in _queue) {

      if( await event_task.InvokeAndReponse(this) == false ) {

        _sensorController.PublishModel();
        return false;
      }

      // if( re.isSuccess == false )
      //   return false;
      //
      // if(item.Invoke() == false)
      //   break;

    }

    await _sensorController.PublishModel();

    return true;
  }


}


void main()
{

}