import 'dart:ui' as ui;
import 'package:daq_dashboard/src/Controllers/MovieClipController.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/LidarGroupModel.dart';
import 'package:daq_dashboard/src/Models/LidarModel.dart';
import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';

import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';


class LidarController extends MovieClipController<LidarModel> {

  LidarController(
      RpcClientRap<GatewayClient>? rpcClientRap ,
      int millisecond,
      metaProperty taggingMetaProperty,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active);


  @override
  void processInit()
  {

    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorConnected,OnProcessIsSensorConnected,OnSensorConnectedSuccess,OnSensorConnectedFail));

    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Acquiring,OnProcessIsSensorAcquiring,OnSensorAcquiringSuccess,OnSensorAcquiringFail));

    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.SensorHealthy,OnProcessIsSensorHealthy,OnSensorHealthySuccess,OnSensorHealthyFail));

    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Snap,OnProcessSensorSnap,OnSnapSuccess,OnSnapFail));


    // eventTaskQueue.init();
    //
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.ControlActive ,OnProcessControlActive,OnControlActiveSuccess,OnControlActiveFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.NetworkConnected,OnProcessNetworkConnected,OnNetworkConnectedSuccess,OnNetworkConnectedFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.None,OnProcessUpdateParam,OnSuccess,OnFail));


  }

  @override
  SensorModel? DefaultModelFactoryMethod() {
    return ModelFactory.DefaultFactory( LidarModel(tag) );
  }

  @override
  SensorModel? ModelFactoryMethod() {
    return ModelFactory.DefaultFactory( LidarModel(tag) );
  }

  //
  //
  //
  // Future<EventTaskResponse> OnProcessIsSensorConnected() async
  // {
  //   print("OnProcessIsSensorConnectedokokokokokokokokokok");
  //
  //   Connection? connection;
  //
  //   try {
  //     connection =
  //     await rpcClientRap?.SendAsyncLocal<Connection, GatewayClient>(
  //             (rpcClient) =>
  //             rpcClient.is_sensor_connected(processingParam.getSafeSensor()!)
  //     );
  //
  //     if ( connection == null || (connection.state != Connection_State.CONNECTED  )  )
  //       return EventTaskResponseResult<Connection>( false , connection);
  //
  //     return EventTaskResponseResult<Connection>( true , connection);
  //   }
  //   catch (e) {
  //     print("OnProcessIsSensorConnected error [ $e ]");
  //     return EventTaskResponseResult<Connection>( false , connection);
  //   }
  // }
  //
  // Future<void> OnSensorConnectedSuccess(EventTaskResponse response) async {
  //   print("OnSensorConnectedSuccess ==================================================");
  //
  // }
  //
  // Future<void> OnSensorConnectedFail(EventTaskResponse response) async {
  //   print("OnSensorConnectedFail ==================================================");
  //
  // }
  //
  //
  //
  //
  // Future<void> OnSensorHealthySuccess(EventTaskResponse response) async {
  //   print("OnSensorHealthySuccess ==================================================");
  //   // EventTaskResponseResult<Health> typedResponse = response as EventTaskResponseResult<Health>;
  //   // Health? health = typedResponse.packet_data as Health;
  //   //
  //   // SensorModel? model = processingParam.getModelAs<SensorModel>();
  //   // model?.health = health;
  // }
  //


}





//
//
// class LidarController extends SensorController {
//
//
//   CameraModel? get cameraModel  {
//
//     return PopModel() as CameraModel?;
//
//   }
//
//   RowImageDTOPool _rowImageContainer = RowImageDTOPool();
//   RowImageDTO? _rowImageDTO;
//
//   LidarController(
//       RpcClientRap<GatewayClient> rpcClientRap ,
//       int millisecond,
//       String tag ,
//       [ bool is_active = false ])
//       : super( rpcClientRap , millisecond , tag , is_active);
//
//
//   @override
//   Future<void> actionRowImage(Sensor sensor, CameraModel camera_model) async {
//
//     try {
//
//       Sensor s = Sensor(name: sensor_name);
//
//       print("l1");
//
//       SensorSnapshot? snapShot =
//       await rpcClientRap.SendAsyncLocal<SensorSnapshot, GatewayClient>(
//               (rpcClient) => rpcClient.get_sensor_snapshot(s)
//       );
//
//       print("l2");
//
//       if (snapShot == null) {
//         print("gRpc Server Response is Null!!!!!!!");
//         return;
//       }
//
//       print("l3");
//       var uint8list = Uint8List.fromList(snapShot.data);
//       var image = await _loadImageFromBytes(uint8list);
//
//       RowImageDTO dto = RowImageDTO(image, snapShot.name);
//       _rowImageContainer.Append(dto);
//       _rowImageDTO = dto;
//
//       camera_model?.row_image = dto;
//
//       print("l4");
//
//
//     }
//     catch (e) {
//       print("ImageController::action() error [ $e ]");
//     }
//   }
//
//
//   @override
//   Future<void> actionState(Sensor sensor , CameraModel camera_model ) async {
//
//     try {
//
//       Connection? connection =
//       await rpcClientRap.SendAsyncLocal<Connection, GatewayClient>(
//               (rpcClient) => rpcClient.is_sensor_connected(sensor)
//       );
//
//       if (connection == null) {
//         print("gRpc Server Response is Null!!!!!!!");
//         return;
//       }
//
//       // Connection c = Connection( state: connection.state , name: connection.name);
//
//       camera_model?.connection = Connection( state: connection.state , name: connection.name);
//
//       Health? health =
//       await rpcClientRap.SendAsyncLocal<Health, GatewayClient>(
//               (rpcClient) => rpcClient.is_sensor_healthy(sensor)
//       );
//
//       if (health == null) {
//         print("gRpc Server Response is Null!!!!!!!");
//         return;
//       }
//
//       camera_model?.health = health;
//
//       Acquisition? acquisition =
//       await rpcClientRap.SendAsyncLocal<Acquisition, GatewayClient>(
//               (rpcClient) => rpcClient.is_sensor_acquiring(sensor)
//       );
//
//       if (acquisition == null) {
//         print("gRpc Server Response is Null!!!!!!!");
//         return;
//       }
//       camera_model?.acquisition = acquisition;
//     }
//     catch (e) {
//       print("ImageController::action() error [ $e ]");
//     }
//
//   }
//
//   Future<void> StartSensorAcquisition() async {
//
//     Sensor sensor = Sensor(name: sensor_name);
//
//     Acquisition? acquisition =
//     await rpcClientRap.SendAsyncLocal<Acquisition, GatewayClient>(
//             (rpcClient) => rpcClient.start_sensor_acquisition(sensor)
//     );
//   }
//
//
//   Future<void> StopSensorAcquisition() async {
//
//     Sensor sensor = Sensor(name: sensor_name);
//
//     Acquisition? acquisition =
//     await rpcClientRap.SendAsyncLocal<Acquisition, GatewayClient>(
//             (rpcClient) => rpcClient.stop_sensor_acquisition(sensor)
//     );
//   }
//
//
//   @override
//   CameraModel? getDefaultModel()
//   {
//     return ModelFactory.DefaultFactory( CameraModel(tag) );
//   }
//
//
//   Future<ui.Image> _loadImageFromBytes(Uint8List bytes) async {
//     final codec = await ui.instantiateImageCodec(bytes);
//     final frame = await codec.getNextFrame();
//     return frame.image;
//   }
//
//   RowImageDTO? PopRowImageDTO() {
//     RowImageDTO? dto = _rowImageDTO;
//     _rowImageDTO = null;
//     return dto;
//
//   }
//
//   @override
//   Future<void> actionSensor() async {
//
//     try
//     {
//       Sensor sensor = Sensor(name: sensor_name);
//
//       CameraModel cameraModel = CameraModel(tag);
//
//       await actionState(sensor,cameraModel);
//       await actionRowImage(sensor,cameraModel);
//
//       AppendModel(cameraModel);
//
//       update();
//     } catch (e) {
//       print("ImageController::action() error [ $e ]");
//     }
//   }
//
// }