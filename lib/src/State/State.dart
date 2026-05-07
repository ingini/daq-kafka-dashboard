import 'package:daq_dashboard/src/State/StateManager.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';


abstract class IState<T> {
  final T _stateId;

  ActionAsync? _onEnterAsync;
  ActionAsync? _onLeaveAsync;
  Action1Async? _onUpdateAsync;

  IState(this._stateId , { ActionAsync? onEnterAsync ,
                           ActionAsync? onLeaveAsync ,
                           Action1Async? onUpdateAsync ,
                         })
  {
    _onEnterAsync = onEnterAsync;
    _onLeaveAsync = onLeaveAsync;
    _onUpdateAsync = onUpdateAsync;
  }

  T get stateId => _stateId;

  Future<void> OnEnterAsync() async {
    await _onEnterAsync?.Invoke();
  }
  Future<void> OnLeaveAsync() async  {
    await _onLeaveAsync?.Invoke();
  }

  Future<void> OnUpdate<REF_PARAM>(REF_PARAM ref_param) async {
    await _onUpdateAsync?.Invoke(ref_param);
  }


}



//
// void main() {
//   print('Hello, World!');
//
//
//   StateManager<E_RecordingState, IState<E_RecordingState>> stateManager = StateManager();
//
//   stateManager.initState(
//       [
//         StateIdle(onEnter : Action(() => print("StateIdle onEnter") ) , onLeave: Action(() => print("StateIdle OnLeave"))),
//         StateRecording(onEnter : Action(() => print("StateRecording onEnter") ) , onLeave: Action(() => print("StateRecording OnLeave")))
//       ],
//       E_RecordingState.Idle);
//
//   // stateManager.registerState(StateWaiting());
//   // stateManager.registerState(StateRecording());
//   // stateManager.setCurrentState(E_RecordingState.Waiting);
//
//   stateManager.changeState(E_RecordingState.Recording);
//
//   stateManager.changeState(E_RecordingState.Idle);
//
// }