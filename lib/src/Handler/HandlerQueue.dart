
import 'package:daq_dashboard/src/Handler/HandlerType.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:flutter/cupertino.dart';

class HandlerQueue<K ,V  > {


  Map _queue = {};

  HandlerQueue() {
    // queue = {};
  }

  void push( K _key, V _value ) {
    _queue[_key] = _value;
  }

  V getValue( K _key ) {
    return _queue[_key];
  }

  V peek( K _key ) {
    return _queue[_key];
  }

  bool isContain( K _key ) {
    return _queue.containsKey(_key);
  }

  // void invork( K _key )  {
  //
  //   if ( isContain(_key) )
  //   {
  //     return _queue[_key]();
  //   }
  // }


  void pop( K _key ) {
    _queue.remove(_key);
  }

  //clear
  void clear() {
    _queue.clear();
  }

  void forEach( Function(K key, V value) callback)  {
    for (var entry in _queue.entries) {
      callback(entry.key, entry.value);
    }
  }

}

//Handler 클래스의 CallBack 에 HandlerType을 줘야 하나?
//HandlerType을 줄 필요가 없다.
//왜??


void F1(){
  print('F1');
}

void F2(){
  print('F2');
}

void F3(){
  print('F3');
}

void main()
{
  HandlerQueue<eHandlerType , void Function()> queue = HandlerQueue<eHandlerType , void Function()>();

  queue.push(eHandlerType.UnActive, F1);
  // queue.push(eHandlerType.NetworkUnConnection, F2);
  queue.push(eHandlerType.SnapSuccess, F3);

  queue.forEach((key, value) {
    value();
  });

}