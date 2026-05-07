


import 'package:daq_dashboard/src/container/CollectionIterator.dart';
import 'package:daq_dashboard/src/container/ICollection.dart';
import 'package:daq_dashboard/src/dataObjects/idto.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';

class MetaModelDto<T extends SensorModel> extends IDTO {


  final T _model;
  final metaProperty _metaProperty;

  MetaModelDto({ required T model, required metaProperty metaProperty} )
  : _model = model,
        _metaProperty = metaProperty;

  T getModel() {
    return _model;
  }

  metaProperty getMetaProperty()
  {
    return _metaProperty;
  }

  String displayName()
  {
    return _metaProperty.display_name;
  }

  Health_Status getDeviceHealthStatus()
  {
    return _model.device_health?.status ?? Health_Status.UNKNOWN;
  }

  Connection_State? getDeviceConnectionStatus()
  {
    return _model.device_connection_state;
  }

  Connection_State? getDevicePingStatus()
  {
    bool pingsuccess = _model.IsPingSuccess();
    return pingsuccess == true ? Connection_State.CONNECTED : null;

  }


  static MetaModelDto Create( eTags etags , SensorModel groupModel )
  {
    metaProperty<SensorModel<IModel>>? _metaProperty = MetaPropertyManager().getMetaProperty(etags);
    SensorModel elementModel = groupModel.getElementModel(_metaProperty!.tag_name);
    return MetaModelDto(model: elementModel, metaProperty: _metaProperty);
  }

}

class MetaModelDtoContainer extends ICollection<MetaModelDto> {

  Map<eTags,MetaModelDto> map = new Map<eTags,MetaModelDto>();

  @override
  void clear() {
    map.clear();
  }

  void Append(eTags key , MetaModelDto value)
  {
    map[key] = value;
  }

  MetaModelDto? Get(eTags key )
  {
    return map[key];
  }

  String getDisplayName(eTags key)
  {
    return map[key]!.displayName();
  }

  Connection_State? getDevicePingStatus(eTags key)
  {
    return map[key]!.getDevicePingStatus();
  }


  Connection_State? getDeviceConnectionState(eTags key)
  {
    return map[key]!.getDeviceConnectionStatus();
  }

  Health_Status? getDeviceHealthStatus(eTags key)
  {
    return map[key]!.getDeviceHealthStatus();
  }

  String toString()
  {
    String sb ="";

    for( eTags k in map.keys )
    {
      sb += " ${k} : ${map[k]!.getDeviceConnectionStatus()} h : ${map[k]!.getDeviceHealthStatus()} \n";
    }

    return sb;
  }



  @override
  ICollectionItorator<MetaModelDto<SensorModel<IModel>>> getCollectionItorator() {
    throw UnimplementedError();
  }


  @override
  int getLength() {
    return map.length;
  }

  @override
  MetaModelDto<SensorModel<IModel>> getValue(int index) {
    return map.values.elementAt(index);
  }

  @override
  bool isEmpty() {
    return map.isEmpty;
  }
}