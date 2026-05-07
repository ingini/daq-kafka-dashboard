
class StackPool< T > {

  final int _size;
  int _currentCurror=-1;

  final List<T> _container = [];

  StackPool( {int size = 10} ) : _size = size;

  //gettter len
  int get len => _container.length;


  int _Size()
  {
    return _container.length;
  }


  void Append( T item )
  {
    _container.add(item);

    while(_container.length > _size)
    {
      // _container.removeFirst();
      _container.removeAt(0);
    }

    _currentCurror = _container.length -1;
  }

  T? Pop()
  {
    T? item;

    if( _Size() > 0 )
      item = _container.removeLast();

    return item;
  }

  T? Peek()
  {
    T? item;

    if( _Size() > 0 )
      item = _container[_container.length - 1];

    return item;
  }

}


