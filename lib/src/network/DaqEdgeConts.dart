//
// import 'package:daq_dashboard/src/utils/enumHelper.dart';
//
// enum eDaqEdgeState
// {
//   None ,
//   Running,
//   Error,
// }
//
//
//
//
// cEnum<eDaqEdgeState, String> initDaqEdgeState() {
//   var _queue = cEnum<eDaqEdgeState, String>();
//   _queue.push(eDaqEdgeState.None, 'None');
//   // _queue.push(eNetworkState.Connecting, 'Connecting');
//   _queue.push(eDaqEdgeState.Running, 'Running');
//   _queue.push(eDaqEdgeState.Error, 'Error');
//   return _queue;
// }
//
// cEnum<eDaqEdgeState, String> E_DaqEdgeState = initDaqEdgeState();
//
//
//
//
// void main(){
//   print( E_DaqEdgeState.getValue(eDaqEdgeState.None));
//   print( E_DaqEdgeState.getValue(eDaqEdgeState.Running));
//   print( E_DaqEdgeState.getValue(eDaqEdgeState.Error));
// }