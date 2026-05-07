


import 'package:daq_dashboard/src/utils/QueuePool.dart';

class LastestStackPool<T> extends StackPool< T > {
  LastestStackPool({int size = 1}) : super(size: size);

  T? item;


  //gettter len
  int get len => this.item == null ? 0 : 1;


  @override
  void Append( T item )
  {
    this.item = item;
    // super.Append(item);
  }

  @override
  T? Pop()
  {
    return this.item;
  }

  @override
  T? Peek()
  {
    return this.item;
  }






}