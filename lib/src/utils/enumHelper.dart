
class cEnum< K  , T>  {

  Map< K  , T> _enumContainer = {};
  Iterator<MapEntry<K, T>>? _iterator;


  void resetIterator() {
    _iterator = _enumContainer.entries.iterator;
  }

  T getValue(K _key)
  {
    return _enumContainer[_key]!;
  }

  bool isContain(K _key)
  {
    return _enumContainer.containsKey(_key);
  }

  int getLenth()
  {
    return _enumContainer.length;
  }

  void push(K _key , T _value )
  {
    _enumContainer[_key] = _value;
  }


  void forEach(void Function(K key, T value) callback) {
    _enumContainer.forEach((key, value) {
      callback(key, value);
    });
  }


  K? getKey(T _value )
  {
    for (var entry in _enumContainer.entries) {
      if (entry.value == _value) {
        return entry.key;
      }
    }
    return null;
  }


  MapEntry<K, T>? next() {
    if (_iterator != null && _iterator!.moveNext())
    {
      return _iterator!.current;
    }
    else
    {
      return null;
    }
  }



}


// void main (){
//   print(networkState.getValue(eNetworkState.None)); // 출력: None
//   print(networkState.getValue(eNetworkState.Connected)); // 출력: Connected
// }
//


//
// void main() {
//   var myEnum = cEnum<String>();
//   myEnum.push(1, "One");
//   myEnum.push(2, "Two");
//   myEnum.push(3, "Three");
//
//   myEnum.resetIterator(); // Iterator 초기화
//
//   // next() 메서드를 사용하여 모든 요소를 순회합니다.
//   while (true) {
//     var entry = myEnum.next();
//     if (entry == null) break; // null이 반환되면 반복을 종료합니다.
//
//     print('Key: ${entry.key}, Value: ${entry.value}');
//   }
// }


//
// void main() {
//   var myEnum = cEnum<String>();
//   myEnum.push(1, "One");
//   myEnum.push(2, "Two");
//   myEnum.push(3, "Three");
//
//   // forEach 메서드를 사용하여 각 키와 값에 대해 작업 수행
//   myEnum.forEach((key, value) {
//     print('Key: $key, Value: $value');
//   });
// }
