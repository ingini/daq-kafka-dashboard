import 'package:daq_dashboard/src/ProcessingState/ProcessingState.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/LidarModel.dart';
import 'package:daq_dashboard/src/Models/ModelContainer.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/Models/TagModel.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';

class GroupModel<T extends IModel> extends IModel {


  ModelContainer<T> _modelContainer = ModelContainer();

  GroupModel( )
  {
    clear();
  }

  void clear() {
    _modelContainer.clear();
  }


  // TODO : 여기선 onModelCreate 이부분을 외부의 메타에서 부터 가지고 와애함 즉 .... onModelCreate 이놈
  // Null 이면 내부에 MetaProperty 에서 얻은 콜백으로 모델을 생성 하면됩니디ㅏ.

  //최종 절대로 인자로 접근 해서 만드는걸 거절 한다.
  //반드시 메타 데이터에 의해서만 만드는걸 허용한다.

  void updateModel( eTags group_tag  ) {
    _modelContainer.clear();

    MetaPropertyElements? elements = MetaPropertyManager().getMetaPropertyElements(group_tag);
    elements?.properties.forEach((key, value) {

      if( value.onModelCreateCallback == null )
      {
        // print("onModelCreateCallback is null");
        return;
      }

      // T elementsModel = ModelFactory.OnCreate( onModelCreate ,value.tag_name);
      T elementsModel = ModelFactory.OnCreate( value.onModelCreateCallback as Func1<String, T> ,value.tag_name);
      // print("888888888888888888888888888888888888888888888888888888888888key: $key, value: ${value.tag_name}");

      _modelContainer.addModel( value.tag_name , elementsModel );
    });
  }


  //coroutine
  Future<void> coRoutine (eTags group_tag , Action1Async<IModel> onProcessRoutine  ) async {


    for( String key in _modelContainer.getContainer.keys )
    {
      IModel model = _modelContainer.getContainer[key]!;

      await onProcessRoutine.Invoke(model);
    }

    // MetaPropertyElements? elements = MetaPropertyManager().getMetaPropertyElements(group_tag);
    //
    // for( eTags etag in elements!.properties.keys )
    // {
    //   metaProperty mp = elements!.properties[etag]!;
    //
    //   onProcessRoutine.Invoke(etag,mp);
    // }
  }


  ModelContainer<T> getModelContainer(){
    return _modelContainer;
  }

  T? getModel(String tag_name){
    return _modelContainer.getModel(tag_name);
  }

  @override
  void setStateStack(ProcessingStateStack stateStack) {
    // TODO: implement setStateStack
  }


}