

import 'dart:typed_data';

import 'dart:ui' as ui;

import 'package:daq_dashboard/src/Controllers/TaskController.dart';
import 'package:daq_dashboard/src/dtos/RowImageDTO.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';

import 'package:daq_dashboard/src/network/networkConts.dart';

import '../protos/daq-service.pbgrpc.dart';

class ImageController extends TaskController {


  late String _tag;
  final String _sensor_name;
  bool _is_active = false;


  RowImageDTOPool _rowImageContainer = RowImageDTOPool();
  RowImageDTO? _rowImageDTO;


  ImageController(
      RpcClientRap<GatewayClient> rpcClientRap ,
      int millisecond,
      String tag ,
      [ bool is_active = false ])
      : _tag = tag ,_sensor_name = tag , _is_active = is_active , super(rpcClientRap , millisecond)
  {
    startTask();
  }


  @override
  IModel? getDefaultModel() {
    // TODO: implement getDefaultModel
    throw UnimplementedError();
  }


  @override
  Future<void> action() async {
    // print("fetchImage!! tag ==> $_tag ");
    //
    if ( _is_active == false )
      return;

    // rpcClientRap.Connect();

    if (rpcClientRap?.networkStatus != eNetworkState.Connected)
      return;


    try {



      print("Img1" );

      Sensor s = Sensor(name: _sensor_name);
      SensorSnapshot? snapShot =
      await rpcClientRap?.SendAsyncLocal<SensorSnapshot, GatewayClient>(
              (rpcClient) => rpcClient.get_sensor_snapshot(s)
      );
      print("Img2" );

      if (snapShot == null) {
        print("gRpc Server Response is Null!!!!!!!");
        return;
      }

      var uint8list = Uint8List.fromList(snapShot.data);
      var image = await _loadImageFromBytes(uint8list);


      RowImageDTO dto = RowImageDTO(image, snapShot.name);

      _rowImageContainer.Append(dto);

      _rowImageDTO = dto;

      print("Img3" );

      // print("gate Controller !!! => $_sensor_name <=====");
      update();
    } catch (e) {
      print("ImageController::action() error [ $e ]");
    }
  }

  Future<ui.Image> _loadImageFromBytes(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  RowImageDTO? PopRowImageDTO() {
    RowImageDTO? dto = _rowImageDTO;
    _rowImageDTO = null;
    return dto;

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


}



