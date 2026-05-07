
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/Models/GroupModel.dart';
import 'package:daq_dashboard/src/Models/LidarModel.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/Models/MovieClipModel.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';


class NetStatusModel extends SensorModel {



  NetStatusModel(String tag)
      : super(tag)
  {
    upsertModel();
  }

  void upsertModel() {

    groupModel.clear();

    // groupModel.updateModel(eTags.lidar,
    //     Func1( ( tag_name) => LidarModel(tag_name) )
    // );

    groupModel.updateModel(eTags.netStatus);
  }





// Connection_State? get connection_state => _connection?.state;


}