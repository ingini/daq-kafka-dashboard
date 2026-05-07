


import 'package:daq_dashboard/src/container/AsyncQueue.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';

class RecordingUploadingQueue<T> extends AsyncQueue<T>
{
  Action1Async<T>? _onRecodingFileUploadingAsyncFunc;

  RecordingUploadingQueue()
      : super()
  {
    // _onRecodingFileUploadingAsyncFunc = onRecodingFileUploadingAsyncFunc;
  }

  void setOnRecodingFileUploadingAsyncFunc( Action1Async<T> onRecodingFileUploadingAsyncFunc )
  {
    _onRecodingFileUploadingAsyncFunc = onRecodingFileUploadingAsyncFunc;
  }


  Future<void> action() async {

    List<T> recodingVoiceFiles =  await getAndClearAllElementsAsync();

    for( T recodingVoiceFile in recodingVoiceFiles )
    {
      if( _onRecodingFileUploadingAsyncFunc != null )
        await _onRecodingFileUploadingAsyncFunc!.Invoke(recodingVoiceFile);
      print("RecordingUploadingQueue action : ${recodingVoiceFile.toString()}");
    }

  }
}








