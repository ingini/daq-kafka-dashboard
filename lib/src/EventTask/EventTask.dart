
import 'dart:ffi';

import 'package:daq_dashboard/src/EventTask/EventTaskQueue.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';
import 'package:daq_dashboard/src/ProcessingState/ProcessingState.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:async/async.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';

// Func only.....
class EventTask<T extends Func<Future<EventTaskResponse>> ,
                S extends Action1Async<EventTaskResponse> ,
                F extends Action1Async<EventTaskResponse>>{

  // final ProcessingState _processingState;
  final eProcessingState _eprocessingState;
  final T _processTask;
  final S? _successCallback;
  final F? _failCallback;

  EventTask( eProcessingState eprocessingState  , T processTask , [S? successCallback , F? failCallback])
      : _eprocessingState = eprocessingState ,
        _processTask = processTask ,
        _successCallback = successCallback ,
        _failCallback = failCallback;

  T get processTask => _processTask;

  // ProcessingState get processingState => _processingState;

  eProcessingState get eprocessingState => _eprocessingState;

  T getProcessTask() {
    return _processTask ;
  }

  Future<EventTaskResponse> Invoke() async {
    return  await _processTask.Invoke();
  }



  Future<bool> InvokeAndReponse(EventTaskQueue event_task_queue) async {

    EventTaskResponse value = await _processTask.Invoke();

    SensorModel smodel = event_task_queue.sensorController.getParamModel();

    if (value.isSuccess)
    {
      await _successCallback?.Invoke(value);
      smodel.setProcessingStateResult(_eprocessingState, true);

      // TODO 이게 필요한가?
      // _processingState.setSuccess(true);

      return true;
    }
    else
    {
      await _failCallback?.Invoke(value);
      // _processingState.setSuccess(false);
      smodel.setProcessingStateResult(_eprocessingState, false );

      return false;
    }
    //
    // await _process_task.Invoke().then((value) {
    //   if(value.isSuccess){
    //     _success_callbak?.Invoke(value);
    //     return true;
    //   }
    //   else
    //   {
    //     _fail_callbask?.Invoke(value);
    //     print("asdasdasddddddd");
    //     return false;
    //   }
    // });
    // return true;
  }

}


class EventTaskFactory {

  static EventTask CreateEventTask<T extends Future<EventTaskResponse> Function()  ,
  C extends Future<void> Function(EventTaskResponse)
  >( eProcessingState eprocessingState , T processCallback , [C? successCallbak, C? failCallbak ]) {

    if( successCallbak == null )
    {
      return EventTask(// ProcessingState.create(eprocessingState) ,
          eprocessingState ,
          Func<Future<EventTaskResponse>>( processCallback) );
    }
    else
    {
      return EventTask( //ProcessingState.create(eprocessingState) ,
          eprocessingState ,
          Func<Future<EventTaskResponse>>( processCallback) ,
          Action1Async<EventTaskResponse>(successCallbak) ,
          Action1Async<EventTaskResponse>(failCallbak!));
    }
  }

}

Future<EventTaskResponse> process_callback( ) async {
  print('Hello, World!');
  return Future.value( EventTaskResult(true));
}



Future<void> OnSuccess(EventTaskResponse response) async {
  // print("Onsuccess");
}



void main() {

  print('Hello, World!');

  var createEventTask = EventTaskFactory.CreateEventTask(
      eProcessingState.ControlActive ,
      process_callback,
      OnSuccess);



  List<IDelegate> li = [ Action(() => print('Hello, World!')) , Action1((int i) => print('Hello, World! $i')) ];

  for (var item in li) {
    if(item is Action){
      item.Invoke();
    }
  }
  //
  // EventTask e1 = EventTask( Func1<String,bool>(
  //         (str)  { return true;  }
  // ));
  //
  // e1.Invoke('s');


  //
  // EventTask e2 = EventTask( Action1<String>((str) => print('Hello, World!' + str)) );
  //
  // e1.getDelegateAs<Action>().Invoke();
  //
  // e2.getDelegateAs<Action1>().Invoke("s");
  //
  // // e2.getDelegate<Action1>().Invoke('!');
  //
  //
  // (e1.delegate as Action).Invoke();
  //





}