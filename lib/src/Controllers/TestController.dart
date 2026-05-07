

import 'dart:typed_data';

import 'dart:ui' as ui;

import 'package:daq_dashboard/src/Controllers/TaskController.dart';
import 'package:daq_dashboard/src/dtos/RowImageDTO.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';

import 'package:daq_dashboard/src/network/networkConts.dart';

import '../protos/daq-service.pbgrpc.dart';
import 'TaskController.dart';

class TestController extends TaskController {

  TestController(super.rpcClientRap, super.millisecond);

  @override
  IModel? getDefaultModel() {
    // TODO: implement getDefaultModel
    throw UnimplementedError();
  }

  @override
  IModel? DefaultModelFactoryMethod() {
    // TODO: implement DefaultModelFactoryMethod
    throw UnimplementedError();
  }

  @override
  IModel? ModelFactoryMethod() {
    // TODO: implement ModelFactoryMethod
    throw UnimplementedError();
  }

  //
  //
  // TestController(RpcClientRap<GatewayClient> rpcClientRap ,
  //     int millisecond,sl
  //     String tag ,
  //     [ bool is_active = false ])
  //     : _tag = tag ,_sensor_name = tag , _is_active = is_active , super(rpcClientRap , millisecond)
  // {
  //   startTask();
  // }



}