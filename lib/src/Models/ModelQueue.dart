



import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/utils/LastestStackPool.dart';
import 'package:daq_dashboard/src/utils/QueuePool.dart';

// class ModelQueue< T extends IModel> extends StackPool< T > {
//   ModelQueue({int queue_size = 10}) : super(size: queue_size);
// }

class ModelQueue< T extends IModel> extends LastestStackPool< T > {
  ModelQueue({int queue_size = 10}) : super(size: queue_size);
}