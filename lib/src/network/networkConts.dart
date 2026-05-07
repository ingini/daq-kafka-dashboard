
import '../utils/enumHelper.dart';

enum eNetworkState
{
  None,
  // Connecting,
  Connected,

  Error,

}

cEnum<eNetworkState, String> initNetworkState() {
  var _queue = cEnum<eNetworkState, String>();
  _queue.push(eNetworkState.None, 'None');
  // _queue.push(eNetworkState.Connecting, 'Connecting');
  _queue.push(eNetworkState.Connected, 'Connected');
  _queue.push(eNetworkState.Error, 'Error');
  return _queue;
}

cEnum<eNetworkState, String> E_NetworkState = initNetworkState();

