



import 'dart:collection';

import 'package:daq_dashboard/src/container/CollectionIterator.dart';
import 'package:daq_dashboard/src/container/ICollection.dart';
import 'package:daq_dashboard/src/container/ICollectionAsync.dart';
import 'package:mutex/mutex.dart';

class AsyncQueue<T> extends ICollectionAsync<T>{

  Queue<T> _queue = Queue<T>();
  var _mutex = Mutex();


  @override
  Future<void> clearAsync() async {
    await _mutex.protect(() async  { _queue.clear(); });
  }

  @override
  Future<int> getLengthAsync() {
    // TODO: implement getLengthAsync
    throw UnimplementedError();
  }

  @override
  Future<T> getValueAsync(int index) async {
    return await _mutex.protect(() async {return _queue.elementAt(index);} );
  }

  @override
  Future<bool> isEmptyAsync() async {
    return await _mutex.protect(() async { return _queue.isEmpty ; });
  }

  Future<void> appendElementAsync(T element) async {
    await _mutex.protect(() async { _queue.add(element); });
  }

  // queue 의 모든 element 의 사본을 뽑고 queue 를 비운다.
  Future<List<T>> getAndClearAllElementsAsync() async {

    return await _mutex.protect(() async {
      List<T> list = _queue.toList();
      _queue.clear();
      return list;
    });
  }


  @override
  ICollectionItorator<T> getCollectionItorator() {
    throw UnimplementedError();
  }

  @override
  int getLength() {
    throw UnimplementedError();

  }

  @override
  getValue(int index) {
    throw UnimplementedError();
  }

  @override
  bool isEmpty() {
    throw UnimplementedError();
  }

  @override
  void clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

}