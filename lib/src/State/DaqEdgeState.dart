

import 'package:daq_dashboard/src/Models/DaqEdgeModel.dart';
import 'package:daq_dashboard/src/State/State.dart';
import 'package:daq_dashboard/src/State/StateManager.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';

enum E_DaqEdgeState
{
  None ,
  Pending,
  Running,
}


class StateNone extends IState<E_DaqEdgeState> {
  StateNone( {ActionAsync? onEnterAsync , ActionAsync? onLeaveAsync, Action1Async<DaqEdgeModel>? onUpdateAsync} )
      : super(E_DaqEdgeState.None , onEnterAsync: onEnterAsync , onLeaveAsync:  onLeaveAsync , onUpdateAsync: onUpdateAsync);
}

class StatePending extends IState<E_DaqEdgeState> {
  StatePending({ActionAsync? onEnterAsync , ActionAsync? onLeaveAsync, Action1Async<DaqEdgeModel>? onUpdateAsync})
      : super(E_DaqEdgeState.Pending, onEnterAsync: onEnterAsync , onLeaveAsync:  onLeaveAsync , onUpdateAsync: onUpdateAsync);
}

class StateRunning extends IState<E_DaqEdgeState> {
  StateRunning({ActionAsync? onEnterAsync , ActionAsync? onLeaveAsync, Action1Async<DaqEdgeModel>? onUpdateAsync})
      : super(E_DaqEdgeState.Running, onEnterAsync: onEnterAsync , onLeaveAsync:  onLeaveAsync , onUpdateAsync: onUpdateAsync);
}



//
// Future<void> main() async {
//   print('Hello, World!');
//
//   StateManager<E_DaqEdgeState, IState<E_DaqEdgeState>> stateManager = StateManager();
//
//   await stateManager.initStateAsync(
//       [
//         StateNone(   onEnterAsync : ActionAsync(() async => print("StateNone onEnter") ) ,    onLeaveAsync: ActionAsync(() async => print("StateNone OnLeave")) ,    onUpdateAsync: ActionAsync(() async => print("StateNone OnUpdate")) ) ,
//         StatePending(onEnterAsync : ActionAsync(() async => print("StatePending onEnter") ) , onLeaveAsync: ActionAsync(() async => print("StatePending OnLeave")) , onUpdateAsync: ActionAsync(() async => print("StatePending OnUpdate")) ),
//         StateRunning(onEnterAsync : ActionAsync(() async => print("StateRunning onEnter") ) , onLeaveAsync: ActionAsync(() async => print("StateRunning OnLeave")) , onUpdateAsync: ActionAsync(() async => print("StateRunning OnUpdate")) )
//       ],
//       E_DaqEdgeState.None);
//
//
//   await stateManager.changeStateAsync(E_DaqEdgeState.Pending);
//   await stateManager.OnUpdate();
//
//   await stateManager.changeStateAsync(E_DaqEdgeState.Running);
//   await stateManager.OnUpdate();
//
//   await stateManager.changeStateAsync(E_DaqEdgeState.None);
//   await stateManager.OnUpdate();
//
// }
