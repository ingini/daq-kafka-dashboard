import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';
import 'package:daq_dashboard/src/container/CollectionIterator.dart';
import 'package:daq_dashboard/src/container/ICollection.dart';

class ProcessingState {

  final eProcessingState _processingState;
  bool _isSuccess = false;

  ProcessingState(  eProcessingState processingState)
  : _processingState = processingState ;

  eProcessingState getProcessingState()
  {
    return _processingState;
  }

  eProcessingState getProcessingStateMark()
  {
    if ( _isSuccess)
      return _processingState;

    return eProcessingState.getState(eProcessingState.getIndex(_processingState) - 1);
  }

  void setSuccess(bool bSuccess)
  {
    _isSuccess = bSuccess;
  }

  bool get isSuccess => _isSuccess;

  void reSet()
  {
    _isSuccess = false;
  }

  static ProcessingState create( eProcessingState processingState )
  {
    return ProcessingState(processingState);
  }
}







class ProcessingStateStack implements ICollection<ProcessingState> {

  List<ProcessingState> _queue = [];

  @override
  ICollectionItorator<ProcessingState> getCollectionItorator() {
    return CollectionItorator(this);
  }

  @override
  int getLength() {
    return _queue.length;
  }

  @override
  ProcessingState getValue(int index) {
    return _queue[index];
  }


  @override
  bool isEmpty() {
    return _queue.isEmpty;
  }

  @override
  void clear() {
    _queue.clear();
  }

  void push( ProcessingState processState  ) {
    _queue.add(processState);
  }

  void resetAll()
  {
    _queue.forEach((element) {element.reSet(); } );
  }

  ProcessingStateStack deepCopy() {
    ProcessingStateStack stack = ProcessingStateStack();
    for (var element in _queue) {
      stack.push(ProcessingState.create(element.getProcessingState()));
    }
    return stack;
  }



  ProcessingState? getProcessingState( eProcessingState processingState )
  {
    for (var element in _queue) {
      if (element.getProcessingState() == processingState) {
        return element;
      }
    }
    return null;
  }


  bool isSuccess( eProcessingState processingState )
  {
    for (var element in _queue) {
      if (element.getProcessingState() == processingState) {
        return element.isSuccess;
      }
    }
    return false;
  }

  String toString(){

    String str = "";
    for (var element in _queue) {
      str += element.getProcessingState().toString() + " : ${element.isSuccess} :::: " + "\n";
    }
    return str;


  }

}