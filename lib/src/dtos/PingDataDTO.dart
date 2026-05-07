



import 'package:daq_dashboard/src/Configure/configUtil.dart';
import 'package:daq_dashboard/src/container/CollectionIterator.dart';
import 'package:daq_dashboard/src/container/ICollection.dart';
import 'package:daq_dashboard/src/dataObjects/idto.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/dtos/PingDTO.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:dart_ping/dart_ping.dart';

class PingDataDTO<K extends eTags > extends IDTO {

  final K _key;
  final PingData _pingData ;
  final PingDTO  _pingDto;

  PingDataDTO( K key , PingData pingData , PingDTO pingDto )
      : _key = key , _pingData = pingData , _pingDto = pingDto;


  K get key => _key;
  K get tags => _key;
  PingData get pingData => _pingData;
  PingDTO get pingDto => _pingDto;


}


//ping data 를 관리하는 놈인데

class PingDataDTOLastest<K extends eTags > extends ICollection<PingDataDTO>{

  Map<K ,PingDataDTO > _pingDataMap = Map<K ,PingDataDTO<K> >();


  @override
  void clear() {
    _pingDataMap.clear();
  }

  void Add( K key , PingDataDTO pingDataDTO ) {
    _pingDataMap[key] = pingDataDTO;
  }

  void UpSert( K key , PingDataDTO pingDataDTO ) {
    _pingDataMap[key] = pingDataDTO;
  }

  PingDataDTO? Get( K key ) {
    return _pingDataMap[key] ;
  }

  bool ContainsKey( K key ) {
    return _pingDataMap.containsKey(key);
  }

  Future<void> coRoutine ( Action1Async<PingDataDTO> onProcessRoutine  ) async {

    for( K key in _pingDataMap.keys )
    {
      PingDataDTO pingDataDTO = _pingDataMap[key]!;

      await onProcessRoutine.Invoke(pingDataDTO);
    }
  }


  @override
  int getLength() {
    return _pingDataMap.length;
  }

  @override
  PingDataDTO getValue(int index) {
    return _pingDataMap.values.elementAt(index);
  }

  @override
  bool isEmpty() {
    return _pingDataMap.isEmpty;
  }

  @override
  ICollectionItorator<PingDataDTO> getCollectionItorator() {

    // TODO: implement getCollectionItorator
    throw UnimplementedError();
  }

}