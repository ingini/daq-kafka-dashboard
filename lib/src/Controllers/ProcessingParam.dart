import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';

class ProcessingParam{

  SensorModel? _model;
  Sensor? _sensor;

  //
  // void updateSensor(Sensor sensor){
  //   _sensor = sensor;
  // }
  //


  //
  // Sensor? getSensor(){
  //   return _sensor;
  // }


  Sensor? getSafeSensor(){

    if(_sensor == null){

      if( _model==null)
        return null;

      setSensor( Sensor( name: _model?.sensor_name ) );
    }

    return _sensor;
  }


  Sensor? getSafeExceptionSensorToCpuSensor(){

    if(_sensor == null){

      if( _model==null)
        return null;

      getSafeSensor();

      String sensorHealthName = MetaPropertyManager().getSensorHealthName(_model!.tag)!;
      return Sensor( name: sensorHealthName );
    }
    else
      {
        String sensorHealthName = MetaPropertyManager().getSensorHealthName(_model!.tag)!;
        return Sensor( name: sensorHealthName );
      }

  }

  void setSensor(Sensor sensor){
    _sensor = sensor;
  }


  void updateModel(IModel? model){
    _model = model as SensorModel?;
  }

  SensorModel? getModel(){
    return _model;
  }

  T? getModelAs<T extends SensorModel>(){
    return _model as T?;
  }

  // IModel? get getModel => _model;

  void setModel(SensorModel? model){
    _model = model;
  }

  void setDeviceConnection(Connection? device_connection)
  {
    _model?.device_connection = device_connection;
  }

  void setSensorConnection(Connection? connection)
  {
    _model?.connection = connection;
  }

  void setDeviceHealth(Health? device_health)
  {
    _model?.device_health = device_health;
  }

  void setSensorHealth(Health? health)
  {
    _model?.health = health;
  }

  void setSensorAcquisition(Acquisition? acquisition)
  {
    _model?.acquisition = acquisition;
  }

}