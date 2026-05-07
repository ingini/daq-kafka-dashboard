
import 'package:daq_dashboard/src/State/State.dart';
import 'package:daq_dashboard/src/State/StateManager.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';

enum E_RecordingState {
  Idle,
  Recording,
}

class StateIdle extends IState<E_RecordingState> {
  StateIdle( {ActionAsync? onEnterAsync , ActionAsync? onLeaveAsync})
      : super(E_RecordingState.Idle ,  onEnterAsync:  onEnterAsync , onLeaveAsync:  onLeaveAsync);
}

class StateRecording extends IState<E_RecordingState> {
  StateRecording( { ActionAsync? onEnterAsync , ActionAsync? onLeaveAsync})
      : super(E_RecordingState.Recording, onEnterAsync:  onEnterAsync , onLeaveAsync:  onLeaveAsync);

}

//
// void main() {
//   print('Hello, World!');
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
// }


