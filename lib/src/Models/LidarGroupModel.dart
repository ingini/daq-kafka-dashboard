
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/Models/GroupModel.dart';
import 'package:daq_dashboard/src/Models/LidarModel.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/Models/MovieClipModel.dart';


class LidarGroupModel extends MovieClipModel {

  LidarGroupModel(super.tag_name)
  {
    upsertModel();
  }

  void upsertModel() {

    groupModel.clear();

    // groupModel.updateModel(eTags.lidar,
    //     Func1( ( tag_name) => LidarModel(tag_name) )
    // );

    groupModel.updateModel(eTags.lidar );
  }

  //
  //
  // LidarGroupModel()
  //     : super(MetaPropertyManager().getMetaProperty(eTags.lidar)!.tag_name)
  // {
  //   upsertModel();
  // }
  //
  //
  // void upsertModel() {
  //
  //   updateModel(eTags.lidar,
  //       Func1( ( tag_name) => LidarModel(tag_name) )
  //   );

  // }


}
