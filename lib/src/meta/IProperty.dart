



import 'dart:ui';

import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:flutter/widgets.dart';

abstract class IProperty {

}


class metaProperty<T extends SensorModel > extends IProperty{

  final eTags tag;
  final String tag_name;
  final String sensor_name;
  // final String _device_name;
  final String display_name;

  final String? sensor_health_name;

  final Func1<String,T>? on_model_create_callback ;

  metaProperty({
    required this.tag,
    required this.tag_name,
    required this.sensor_name,
    required this.display_name,
    this.on_model_create_callback,
    this.sensor_health_name
});

  //
  // metaProperty(
  //     required this._tag,
  //     this._tag_name ,
  //     this._sensor_name  ,
  //     this._display_name ,
  //     [ this._on_model_create_callback ] );
  //
  // //getter
  // String get tag_name => _tag_name;
  // String get sensor_name => _sensor_name;
  // // String get device_name => _device_name;
  // String get display_name => _display_name;
  Func1<String,T>? get onModelCreateCallback => on_model_create_callback;

  // metaProperty( this._tag, this._tag_name ,
  //     this._sensor_name  ,
  //     this._display_name ,
  //     [ this._on_model_create_callback ] );
  //
  // //getter
  // eTags  get tag => _tag;
  // String get tag_name => _tag_name;
  // String get sensor_name => _sensor_name;
  // // String get device_name => _device_name;
  // String get display_name => _display_name;
  // Func1<String,T>? get onModelCreateCallback => _on_model_create_callback;


}


class lidarIconProperty extends IProperty{

  final eTags _tag;
  final eLidarType _lidar_type;
  final double _rotate_angle;

  lidarIconProperty( this._tag , this._lidar_type , this._rotate_angle );

  //getter
  eTags get tag => _tag;
  eLidarType get lidar_type => _lidar_type;
  double get rotate_angle => _rotate_angle;


}

class widgetProperty extends IProperty{

  final eWidgetType _ewidget_type;
  final Offset _position;
  final Size _size;

  final Func1< eTags , Widget> _createCallBack;

  widgetProperty(eWidgetType ewidget_type , Offset position , Size size , Func1< eTags , Widget> createCallBack  )
      :
        _ewidget_type = ewidget_type,
        _position = position,
        _size = size,
        _createCallBack = createCallBack;

  //getter
  eWidgetType  get ewidget_type => _ewidget_type;
  Offset get position => _position;
  Size get size => _size;

  Widget createWidget(eTags tag) {
    return _createCallBack.Invoke(tag);
  }




}
