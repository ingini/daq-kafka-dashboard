
abstract class IDelegate{

}

class Action extends IDelegate{
  final void Function() _action;
  Action(this._action);
  void Invoke(){
    _action();
  }
}

class ActionAsync extends IDelegate{
  final Future<void> Function() _action;
  ActionAsync(this._action);
  Future<void> Invoke() async {
    await _action();
  }
}

class Action1<T> extends IDelegate{
  final void Function(T) _action;
  Action1(this._action);
  void Invoke(T t1){
    _action(t1);
  }
}

class Action1Async<T> extends IDelegate{
  final Future<void> Function(T) _action;
  Action1Async(this._action);
  Future<void> Invoke(T t1) async {
    await _action(t1);
  }
}


class Action2<T1 , T2> extends IDelegate{
  final void Function(T1,T2) _action;
  Action2(this._action);
  void Invoke(T1 t1 , T2 t2 ){
    _action(t1 , t2);
  }
}

class Action2Async<T1 , T2> extends IDelegate{
  final Future<void> Function(T1,T2) _action;
  Action2Async(this._action);
  Future<void> Invoke(T1 t1 , T2 t2 ) async {
    await _action(t1 , t2);
  }
}


class Action3<T1 , T2 , T3> extends IDelegate{
  final void Function(T1,T2,T3) _action;
  Action3(this._action);
  void Invoke(T1 t1 , T2 t2 , T3 t3 ){
    _action(t1 , t2 , t3);
  }
}

class Action3Async<T1 , T2 , T3> extends IDelegate{
  final Future<void> Function(T1,T2 , T3) _action;
  Action3Async(this._action);
  Future<void> Invoke(T1 t1 , T2 t2 , T3 t3 ) async {
    await _action(t1 , t2 , t3);
  }
}



class Func<T> extends IDelegate{
  final T Function() _action;
  Func(this._action);
  T Invoke(){
    return _action();
  }
}

class FuncAsync<T> extends IDelegate{
  final Future<T> Function() _action;
  FuncAsync(this._action);
  Future<T> Invoke() async {
    return await _action();
  }
}

class Func1<T,R> extends IDelegate{
  final R Function(T) _action;
  Func1(this._action);
  R Invoke(T t1){
    return _action(t1);
  }
}

class Func1Async<T,R> extends IDelegate{
  final Future<R> Function(T) _action;
  Func1Async(this._action);
  Future<R> Invoke(T t1) async{
    return await _action(t1);
  }
}


class Func2<T1,T2,R> extends IDelegate{
  final R Function(T1,T2) _action;
  Func2(this._action);
  R Invoke(T1 t1 , T2 t2){
    return _action(t1 , t2);
  }
}

class Func2Async<T1,T2,R> extends IDelegate{
  final Future<R> Function(T1,T2) _action;
  Func2Async(this._action);
  Future<R> Invoke(T1 t1 , T2 t2) async {
    return await _action(t1 , t2);
  }
}


class Func3<T1,T2,T3,R> extends IDelegate{
  final R Function(T1,T2,T3) _action;
  Func3(this._action);
  R Invoke(T1 t1 , T2 t2 , T3 t3){
    return _action(t1 , t2 , t3);
  }
}

class Func3Async<T1,T2,T3,R> extends IDelegate{
  final Future<R> Function(T1,T2,T3) _action;
  Func3Async(this._action);
  Future<R> Invoke(T1 t1 , T2 t2, T3 t3) async {
    return await _action(t1 , t2 , t3);
  }
}




void main(){
  print('Hello, World!');

  List<IDelegate> li = [ Action(() => print('Hello, World!')) , Action1((int i) => print('Hello, World! $i')) ];

  for (var item in li) {
    if(item is Action){
      item.Invoke();
    }
    else if(item is Action1){
      item.Invoke(1);
    }
  }

  Func1<int, String> func1_int_string = Func1((int i) {
    // 여러 작업 수행
    print("Executing Func1 with parameter: $i");
    print("Performing some tasks...");
    return 'Hello, World! $i';
  });


  Func1<String,bool> func1 = Func1((str)  { return true;  });


  //
  // //Func
  // Func<int> func = Func(() => 1);
  // print(func.Invoke());
  //
  // // func();
  //
  //
  // //Func1
  // Func1<int,String> func1 = Func1((int i) => 'Hello, World! $i');
  // print(func1.Invoke(1));
  //
  //
  // li.add(func);
  // li.add(func1);
  //
  //
  // print("=======================");
  //
  // for (var item in li) {
  //   if(item is Action){
  //     item.Invoke();
  //   }
  //   else if(item is Action1){
  //     item.Invoke(1);
  //   }
  //   else if(item is Func){
  //     print(item.Invoke());
  //   }
  //   else if(item is Func1){
  //     print(item.Invoke(1));
  //   }
  // }



  //
  //
  // Action action = Action(() => print('Hello, World!'));
  // action.Invoke();
  //
  // Action1<int> action1 = Action1((int i) => print('Hello, World! $i'));
  // action1.Invoke(1);


}