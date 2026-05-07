import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/ModelContainer.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/MovieClipModel.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';



class LidarModel extends MovieClipModel {

  // ModelContainer<SensorModel> _modelContainer = ModelContainer();

  LidarModel(String tag)
      : super(tag)
  {
    // init();
  }

  // void init() {
  //   // _modelContainer.clear();
  //
  //   MetaPropertyElements? elements = MetaPropertyManager().getMetaPropertyElements(eTags.lidar);
  //   elements?.properties.forEach((key, value) {
  //
  //     SensorModel elementsModel = ModelFactory.Create( LidarModel(value.tag_name) );
  //     print("key: $key, value: ${value.tag_name}");
  //
  //     _modelContainer.addModel( value.tag_name , elementsModel );
  //   });
  //
  // }

}


