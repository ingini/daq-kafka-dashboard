
import 'package:daq_dashboard/src/dtos/ConnectionDTO.dart';
import 'package:daq_dashboard/src/dtos/RowImageDTO.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/jsonModels/StorageData.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/Models/TagModel.dart';
import 'package:daq_dashboard/src/protos/daq-service.pbenum.dart';
import 'package:daq_dashboard/src/protos/daq-service.pbgrpc.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:sprintf/sprintf.dart';

import '../protos/daq-service.pb.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';


class StorageModel extends SensorModel {

  bool _is_success = false;
  StorageData _storageData = StorageData( total: 0,used: 0,free: 0);





  StorageModel(String tag )
      : super(tag);


  // bool get isSuccess => _is_success;

  //setter getter
  StorageData get storageData => _storageData;
  set storageData(StorageData value) {
    _storageData = value;
  }


  bool isSuccessFull(){
    return _is_success;
  }

  set isSuccess(bool value) {
    _is_success = value;
  }

  double getTotalTB(){
    return _storageData.total / 1024 / 1024 / 1024 / 1024;
  }

  double getUsedTB(){
    return _storageData.used / 1024 / 1024 / 1024 / 1024;
  }

  double getFreeTB(){
    return _storageData.free / 1024 / 1024 / 1024 / 1024;
  }


  String getTotalTBStr(){
    return getTotalTB().toStringAsFixed(0);
  }

  String getUsedTBStr(){
    return getUsedTB().toStringAsFixed(0);
  }

  String getFreeTBStr(){
    return getFreeTB().toStringAsFixed(0);
  }


  ///////////////////
  // ui message
  ///////////////////

  String stockMessageFormat = " Total : %s gb Used : %s gb Free : %s %";


  String _getStockMes( StorageData storage_data )
  {

    if(storage_data == null )
      return sprintf(stockMessageFormat, ["-", "-", "-"]);

    if( !IsStateSuccess(eProcessingState.Snap ) )
      return sprintf(stockMessageFormat, ["-", "-", "-"]);

    // if ( connection == null || storage_data == null ) {
    //   return sprintf(stockMessageFormat, ["-", "-", "-"]);
    // }
    //
    // if( connection.state != Connection_State.CONNECTED ) {
    //   return sprintf(stockMessageFormat, ["-", "-", "-"]);
    // }

    storage_data.total;
    storage_data.used;
    storage_data.free;

    double totalGB = storage_data.total / 1024 / 1024 / 1024;
    double usedGB = storage_data.used / 1024 / 1024 / 1024;

    double remainAge = 100 * (storage_data.total - storage_data.used) / storage_data.total;

    return sprintf(stockMessageFormat, [
      totalGB.toStringAsFixed(2),
      usedGB.toStringAsFixed(2),
      remainAge.toStringAsFixed(2)
    ]);
  }



  String getUIStorageConnected() {
    return IsStateSuccess(eProcessingState.DeviceConnected) ? "Connected" : "Disconnected";
    //
    // if( _connection == null ) {
    //   return "Disconnected";
    // }
    //
    // return _connection?.state == Connection_State.CONNECTED ? "Connected" : "Disconnected";
  }

  String getUIStorageStock() {

    // if(!IsStateSuccess(eProcessingState.Snap)) {
    //   return "";
    // }

    // return IsStateSuccess(eProcessingState.Snap)? "Connected" : "Disconnected";
    //
    // if( _connection == null ) {
    //   return "";
    // }

    return _getStockMes( _storageData);

    // return _connection?.state == Connection_State.CONNECTED ? "Connected" : "Disconnected";
  }

  double getUIRemainStock() {

    if(!IsStateSuccess(eProcessingState.Snap))
      return 0;
      //
      // if( _connection == null || _storageData == null ) {
      //   return 0;
      // }

      if( _storageData.total == 0 )
        return 0;



      return ( _storageData.used) / _storageData.total;
  }


}


