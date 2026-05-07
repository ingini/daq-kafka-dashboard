



class stopWatch {


  DateTime? _startTime ;
  DateTime? _endTime ;

  DateTime get startTime => _startTime!;
  DateTime get endTime => _endTime!;

  set startTime(DateTime value) {
    _startTime = value;
  }

  set endTime(DateTime value) {
    _endTime = value;
  }




  stopWatch() {
    print("StopWatch");
  }

  void start() {
    startTime = DateTime.now();
  }

  void stop() {
    endTime = DateTime.now();
    Duration duration = endTime.difference(startTime);
    print("Duration: ${duration.inSeconds}");
  }

  bool isDurationMillisecond(int milliseconds) {
    DateTime currentTime = DateTime.now();
    Duration duration = currentTime.difference(startTime);
    return duration.inMilliseconds > milliseconds;
  }

  bool isDurationsecond(int seconds) {
    DateTime currentTime = DateTime.now();
    Duration duration = currentTime.difference(startTime);
    return duration.inSeconds > seconds;
  }

  void reset() {
    _startTime = null;
  }

}


void main() {


  stopWatch watch = stopWatch();
  watch.start();
  watch.stop();
  watch.reset();
  watch.start();
  watch.stop();
}