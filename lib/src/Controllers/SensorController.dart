import 'package:daq_dashboard/src/Controllers/NotificationController.dart';
import 'package:daq_dashboard/src/Controllers/PopupController.dart';
import 'package:daq_dashboard/src/Controllers/ProcessingParam.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskQueue.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';
import 'package:daq_dashboard/src/Handler/HandlerType.dart';
import 'package:daq_dashboard/src/Handler/abSensorHandler.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/ModelQueue.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/network/networkConts.dart';

import 'package:daq_dashboard/src/Controllers/TaskController.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';

import 'package:daq_dashboard/src/ProcessingState/ProcessingState.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';
import 'package:get/get.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';


abstract class SensorController<T extends SensorModel > extends TaskController {
// abstract class SensorController<T extends IModel > extends TaskController {

  bool _is_active = false;
  final metaProperty _taggingMetaProperty ;

  ProcessingStateStack _processingStateStack = ProcessingStateStack();
  late EventTaskQueue _eventTaskQueue;

  ProcessingParam processingParam = ProcessingParam();

  ModelQueue<IModel> _modelQueue = ModelQueue();
  final PopupController popupController;

  //setter getter
  String get tag => _taggingMetaProperty.tag_name;
  String get sensor_name => _taggingMetaProperty.sensor_name;
  bool get is_active => _is_active;

  set is_active(bool value) => _is_active = value;

  //getter
  EventTaskQueue get eventTaskQueue => _eventTaskQueue;


  ModelQueue<IModel> get modelQueue => _modelQueue;


  //setter getter
  SensorController(
      RpcClientRap<GatewayClient>? rpcClientRap ,
      int millisecond,
      metaProperty taggingMetaProperty ,
      [ bool is_active = false ])
      : _taggingMetaProperty = taggingMetaProperty , _is_active = is_active ,
        popupController = Get.find(tag: MetaPropertyManager().getTagName( eTags.popup )) ,
        super(rpcClientRap , millisecond)
  {
    _eventTaskQueue = EventTaskQueue(_processingStateStack,this);

    // popupController = Get.find(tag: MetaPropertyManager().getTagName( eTags.popup ));

    SProcessInit();
    startTask();
  }

  // 공통 비동기 초기화 메서드
  @override
  Future<void> initializeAsync() async {
    // 여기에 공통 초기화 작업 추가
    // await Future.delayed(Duration(seconds: 1));
    print('SensorController initialized');
  }

  @override
  void processInit();

  @override
  void SProcessInit(){


    eventTaskQueue.init();

    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.ControlActive ,OnProcessControlActive,OnControlActiveSuccess,OnControlActiveFail));
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.NetworkConnected,OnProcessNetworkConnected,OnNetworkConnectedSuccess,OnNetworkConnectedFail));
    // eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.None,OnProcessUpdateParam,OnSuccess,OnFail));

    processInit();

  }

  IModel? PopModel()
  {
    if ( _modelQueue.len == 0 ) {

      return DefaultModelFactory(this);
    }

    return _modelQueue.Pop();
  }

  // Model Factorys

  // SensorModel? DefaultModelFactory( SensorController controller )
  // {
  //   SensorModel? model = DefaultModelFactoryMethod();
  //   model?.stateStack = _processingStateStack.deepCopy();
  //   return model;
  // }
  //
  // SensorModel? ModelFactory(SensorController controller)
  // {
  //   SensorModel? model = DefaultModelFactoryMethod();
  //   model?.stateStack = _processingStateStack.deepCopy();
  //   return model;
  // }
  //
  // SensorModel? DefaultModelFactoryMethod();
  // SensorModel? ModelFactoryMethod();
  
  //TOOD Model 추상화

  IModel? DefaultModelFactory( SensorController controller )
  {
    SensorModel? model = DefaultModelFactoryMethod();
    model?.setStateStack(_processingStateStack.deepCopy());
    // model?.stateStack = _processingStateStack.deepCopy();
    return model;
  }

  IModel? ModelFactory(SensorController controller)
  {
    SensorModel? model = DefaultModelFactoryMethod();
    model?.setStateStack(_processingStateStack.deepCopy());
    // model?.stateStack = _processingStateStack.deepCopy();
    return model;
  }

  SensorModel? DefaultModelFactoryMethod();
  SensorModel? ModelFactoryMethod();
  


  IModel? getModel() {
    return PopModel();
  }


  void AppendModel(IModel model)
  {
    // (model as T).stateStack = _processingStateStack;
    _modelQueue.Append(model);
  }


  void ResetParamModel(ProcessingStateStack processingStateStack)
  {
    SensorModel model = DefaultModelFactory(this) as SensorModel;
    processingParam.updateModel(model);
  }

  SensorModel getParamModel()
  {
     return processingParam.getModel() as SensorModel;
  }

  Future<void> PublishModel() async
  {

    IModel? model = processingParam.getModel();

    if(model != null)
    {
      AppendModel(model);
      // print("====== PublishModel=====");
      update();
    }

    // AppendModel(processingParam.getModel()!);
    // update();
  }

  /////////////// On Tab CallBack ////////////////////

  //수집 체크 and 결과에 따라서 수집 및 정지를 한다,

  Future<Acquisitions> StartAllAcquisitionOnSensor() async
  {
    Acquisitions? acquisitions =
    await rpcClientRap?.SendAsyncLocal<Acquisitions, GatewayClient>(
            (rpcClient) =>
            rpcClient.start_all_sensor_acquisition(void_())
    );

    return acquisitions!;
  }


  Future<Acquisitions> StopAllAcquisitionOnSensor() async
  {
    Acquisitions? acquisitions =
    await rpcClientRap?.SendAsyncLocal<Acquisitions, GatewayClient>(
            (rpcClient) =>
            rpcClient.stop_all_sensor_acquisition(void_())
    );

    return acquisitions!;
  }


  Future<Acquisition> IsSensorAcquiringOnSensor(Sensor s) async
  {
    Acquisition? acquisition =
    await rpcClientRap?.SendAsyncLocal<Acquisition, GatewayClient>(
            (rpcClient) =>
            rpcClient.is_sensor_acquiring(s)
    );

    return acquisition!;
  }


  Future<Acquisition> StartSensorAcquisitionOnSensor(Sensor s) async
  {
    Acquisition? acquisition =
    await rpcClientRap?.SendAsyncLocal<Acquisition, GatewayClient>(
            (rpcClient) =>
            rpcClient.start_sensor_acquisition(s)
    );

    return acquisition!;
  }


  Future<Acquisition> StopSensorAcquisitionOnSensor(Sensor s) async
  {
    Acquisition? acquisition =
    await rpcClientRap?.SendAsyncLocal<Acquisition, GatewayClient>(
            (rpcClient) =>
            rpcClient.stop_sensor_acquisition(s)
    );

    return acquisition!;
  }

  Future<void> OnTapStartAllAcquiring() async {
    print("OnTapStartAllAcquiring");

    try{
      Acquisitions? acquisitions = await StartAllAcquisitionOnSensor();
    }
    catch (e) {
      print("OnTapStartAllAcquiring error [ $e ]");
      popupController.setErrorPopup(e.toString());
    }


  }

  Future<void> OnTapStopAllAcquiring() async {
    try {
      Acquisitions? acquisitions = await StopAllAcquisitionOnSensor();
    }
    catch (e) {
      print("OnTapStopAllAcquiring error [ $e ]");
      popupController.setErrorPopup(e.toString());
    }
  }

  Future<void> OnTapWidget() async{
    print("OnTapWidget");


    Sensor s = Sensor(name: sensor_name);


    Acquisition? acquisition;

    try {
      acquisition =
      await IsSensorAcquiringOnSensor(s);

    }
    catch (e) {
      // error popup
      print("OnProcessIsSensorHealthy error [ $e ]");
      popupController.setErrorPopup(e.toString());
    }

    if ( acquisition == null  )
    {
      popupController.setErrorPopup("Acquisition is null");
      return ;
    }

    if ( acquisition?.state == Acquisition_State.UNKNOWN )
    {
      popupController.setErrorPopup("Acquisition is Unknow Error [${acquisition.reason}]");
      return ;
    }


    if ( acquisition?.state == Acquisition_State.ACQUIRING )
    {
      acquisition = await StopSensorAcquisitionOnSensor(s);

    }
    else if ( acquisition?.state == Acquisition_State.NOT_ACQUIRING )
    {
      acquisition = await StartSensorAcquisitionOnSensor(s);
    }
    else
    {
      popupController.setErrorPopup("Acquisition is Unknow Error [${acquisition.reason}]");
      return ;
    }


      // popupController.setPopup("Test Popup");
    // 서버랑 통신 하고
    // Get 헤서 popup Controller 부르고
  }


///// CALLBACKS

  Future<void> OnSuccess(EventTaskResponse response) async {
    // print("Onsuccess");
  }

  Future<void> OnFail(EventTaskResponse response) async {
    print("OnFail");
  }

  //이놈을 불러 주는 곳에 가서 처리를 한다.
  Future<void> OnControlActiveSuccess(EventTaskResponse response) async {
    // print("OnControlActiveSuccess");
  }

  Future<void> OnControlActiveFail(EventTaskResponse response) async {
    // print("OnControlActiveFail");
  }

  Future<void> OnNetworkConnectedSuccess(EventTaskResponse response) async {
    // print("OnNetworkConnectedSuccess");
  }

  Future<void> OnNetworkConnectedFail(EventTaskResponse response) async {
    // print("OnNetworkConnectedFail");
  }


  Future<void> OnDeviceConnectedSuccess(EventTaskResponse response) async {

    EventTaskResponseResult<Connection> typedResponse = response as EventTaskResponseResult<Connection>;
    Connection? connection = typedResponse.packet_data as Connection;

    SensorModel? model = processingParam.getModelAs<SensorModel>();
    model?.device_connection = connection;

  }

  Future<void> OnDeviceConnectedFail(EventTaskResponse response) async {
    print("OnDeviceConnectedFail");
  }

  Future<void> OnDeviceHealthySuccess(EventTaskResponse response) async {
    // print("OnSensorHealthySuccess");
    EventTaskResponseResult<Health> typedResponse = response as EventTaskResponseResult<Health>;
    Health? health = typedResponse.packet_data as Health;

    SensorModel? model = processingParam.getModelAs<SensorModel>();
    model?.device_health = health;
  }

  Future<void> OnDeviceHealthyFail(EventTaskResponse response) async {
    print("OnDeviceHealthyFail");
  }


  Future<void> OnSensorConnectedSuccess(EventTaskResponse response) async {

    // Connection? connection = response.getPacketData();
    //
    // SensorModel? model = processingParam.getModelAs<SensorModel>();
    // model?.connection = connection;



    // EventTaskResponseResult<Connection> typedResponse = response as EventTaskResponseResult<Connection>;
    // Connection? connection = typedResponse.packet_data as Connection;
    //
    // SensorModel? model = processingParam.getModelAs<SensorModel>();
    // model?.connection = connection;

  }

  Future<void> OnSensorConnectedFail(EventTaskResponse response) async {
    // print("OnSensorConnectedFail");
  }


  Future<void> OnProcessUserCustomSuccess(EventTaskResponse response) async {

  }

  Future<void> OnProcessUserCustomFail(EventTaskResponse response) async {

  }


  Future<void> OnSensorHealthySuccess(EventTaskResponse response) async {
    // print("OnSensorHealthySuccess");
    // EventTaskResponseResult<Health> typedResponse = response as EventTaskResponseResult<Health>;
    // Health? health = typedResponse.packet_data as Health;
    //
    // SensorModel? model = processingParam.getModelAs<SensorModel>();
    // model?.health = health;
  }

  Future<void> OnSensorHealthyFail(EventTaskResponse response) async {

    //
    // EventTaskResponseResult<Health> typedResponse = response as EventTaskResponseResult<Health>;
    // // Health? health = typedResponse.packet_data as Health;
    // //
    // // print("OnSensorHealthyFail : ${health.status.toString()}  >> : ${health.reason}");

  }

  Future<void> OnSensorAcquiringSuccess(EventTaskResponse response) async {
    // print("OnSensorAcquiringSuccess");
    // EventTaskResponseResult<Acquisition> typedResponse = response as EventTaskResponseResult<Acquisition>;
    // Acquisition? acquisition = typedResponse.packet_data as Acquisition;
    //
    // SensorModel? model = processingParam.getModelAs<SensorModel>();
    // model?.acquisition = acquisition;
  }

  Future<void> OnSensorAcquiringFail(EventTaskResponse response) async {
    print("OnSensorAcquiringFail");
  }

  Future<void> OnSnapSuccess(EventTaskResponse response) async {
    // print("OnSnapSuccess");
  }

  Future<void> OnSnapFail(EventTaskResponse response) async {
    print("OnSnapFail");

    //
    // AppendModel(processingParam.getModel()!);
    //
    // update();


  }

  // 2개의 체크를 해야함..

  // 1. ui 상으로 active 인가?

  // 2. network 상태가 connected 인가?

  // 3. sensor 상태가 connected 인가?

  // 4. sensor 상태가 healthy 인가?

  // 5. snap 이 성공적으로 되었는가?

  // 6. snap 이 실패하였는가?

  // 7. exception 이 발생하였는가?

  // void OnBtnTest()
  // {
  //   print("awdwadwada");
  // }


  Future<EventTaskResponse> OnProcessControlActive() async
  {
    // print("OnProcessIsActive tag : $tag _is_active : $_is_active");
    return EventTaskResult(_is_active);
  }

  Future<EventTaskResponse> OnProcessNetworkConnected() async
  {
    // print("OnProcessNetworkConnected");
    return EventTaskResult(rpcClientRap?.networkStatus == eNetworkState.Connected);
  }

  Future<EventTaskResponse> OnProcessUserCustom() async
  {
    return EventTaskResult(true);
  }

  Future<EventTaskResponse> OnProcessUpdateParam() async
  {
    // print("OnProcessCreateModel");

    processingParam.updateModel(ModelFactory( this ));
    // processingParam.updateSensor(Sensor(name: sensor_name));
    return EventTaskResult(true);
  }

  Future<EventTaskResponse> OnProcessDeviceConnected() async
  {
    // print("OnActTest tag : $tag");

    Device device = Device(name: sensor_name);

    Connection? connection;

    try {
      connection =
      await rpcClientRap?.SendAsyncLocal<Connection, GatewayClient>(
              (rpcClient) => rpcClient.is_dev_connected(device)
      );

      if (connection == null|| (connection.state != Connection_State.CONNECTED  )) {
        print("gRpc Server Response is Null!!!!!!!");
        return EventTaskResponseResult<Connection>(false, connection);
      }
      // deviceModel.connection = connection;
      return EventTaskResponseResult<Connection>(true, connection);
    }
    catch (e) {
      print("DeviceController::OnProcessDevConnected() error [ $e ]");
      return EventTaskResponseResult<Connection>(false, connection);
    }

  }


  Future<EventTaskResponse> OnProcessDeviceHealthy() async
  {
    // print("OnActTest tag : $tag");

    Device device = Device(name: sensor_name);

    Health? health;

    try {
      health =
      await rpcClientRap?.SendAsyncLocal<Health, GatewayClient>(
              (rpcClient) => rpcClient.is_dev_healthy(device)
      );

      if (health == null || (health.status != Health_Status.GOOD)) {
        print("gRpc Server Response is Null!!!!!!!");
        return EventTaskResponseResult<Health>(false, health);
      }
      // deviceModel.connection = connection;
      return EventTaskResponseResult<Health>(true, health);
    }
    catch (e) {
      print("DeviceController::OnProcessDevConnected() error [ $e ]");
      return EventTaskResponseResult<Health>(false, health);
    }

  }

  Future<EventTaskResponse> OnProcessIsSensorConnected() async
  {
    // print("OnProcessIsSensorConnected");

    Connection? connection;

    try {
      connection =
      await rpcClientRap?.SendAsyncLocal<Connection, GatewayClient>(
              (rpcClient) =>
              rpcClient.is_sensor_connected(processingParam.getSafeSensor()!)
      );

      processingParam.setSensorConnection(connection);

      if ( connection == null || (connection.state != Connection_State.CONNECTED  )  )
        return EventTaskResponseResult<Connection>( false , connection);

      return EventTaskResponseResult<Connection>( true , connection);
    }
    catch (e) {
      print("OnProcessIsSensorConnected error [ $e ]");
      return EventTaskResponseResult<Connection>( false , connection);
    }
  }

  Future<EventTaskResponse> OnProcessIsSensorHealthy() async
  {
    // print("OnProcessIsSensorHealthy");

    Health? health;

    try {
      health =
      await rpcClientRap?.SendAsyncLocal<Health, GatewayClient>(
              (rpcClient) => rpcClient.is_sensor_healthy(processingParam.getSafeSensor()!)
      );

      processingParam.setSensorHealth(health);

      if (health== null )
        return EventTaskResponseResult<Health>( false , health);

      if (health.status != Health_Status.GOOD)
        notificationController.addNotification("Not Healthy: ${health.reason}");
        // NotificationController.getController().setNotification("Sensor is not healthy", "Sensor is not healthy");

      // if (health== null || (health.status != Health_Status.GOOD) )
      //   return EventTaskResponseResult<Health>( false , health);

      return EventTaskResponseResult<Health>( true , health);
    }
    catch (e) {
      print("OnProcessIsSensorHealthy error [ $e ]");
      return EventTaskResponseResult<Health>( false , health);
    }
  }


  Future<EventTaskResponse> OnProcessIsSensorAcquiring() async
  {
    Acquisition? acquisition;

    try {
      acquisition =
      await rpcClientRap?.SendAsyncLocal<Acquisition, GatewayClient>(
              (rpcClient) => rpcClient.is_sensor_acquiring(processingParam.getSafeSensor()!)
      );

      processingParam.setSensorAcquisition(acquisition);

      if( acquisition == null )
        return EventTaskResponseResult<Acquisition>( true , acquisition);

      return EventTaskResponseResult<Acquisition>( true , acquisition);
    }
    catch (e) {
      print("OnProcessIsSensorHealthy error [ $e ]");
      return EventTaskResponseResult<Acquisition>( true , acquisition);
    }
  }


  Future<EventTaskResponse> OnProcessSensorSnap() async
  {
    // print("OnProcessSensorSnap");

    SensorSnapshot? snapShot;

    try {
      snapShot =
      await rpcClientRap?.SendAsyncLocal<SensorSnapshot, GatewayClient>(
              (rpcClient) => rpcClient.get_sensor_snapshot(processingParam.getSafeSensor()!)
      );

      if( snapShot == null )
        return EventTaskResponseResult<SensorSnapshot>( false , snapShot);


      if(Defines.isSameContextType(snapShot.contentType, eNetSnapShapContentType.UnKnown) )
      {
        notificationController.addNotification("Snap Error : ${snapShot.name} , ${snapShot.contentType}");
        return EventTaskResponseResult<SensorSnapshot>( false , snapShot);
      }

      // if( snapShot.contentType.toUpperCase() == "unknown".toUpperCase() )
      //   return EventTaskResponseResult<SensorSnapshot>( false , snapShot);

      return EventTaskResponseResult<SensorSnapshot>( true , snapShot);
    }
    catch (e) {
      print("OnProcessSensorSnap error [ $e ]");
      return EventTaskResponseResult<SensorSnapshot>( false , snapShot);
    }
  }



  Future<void> StartSensorAcquisition() async {


    Sensor sensor = Sensor(name: sensor_name);

    Acquisition? acquisition =
    await rpcClientRap?.SendAsyncLocal<Acquisition, GatewayClient>(
            (rpcClient) => rpcClient.start_sensor_acquisition(sensor)
    );
  }


  Future<void> StopSensorAcquisition() async {

    Sensor sensor = Sensor(name: sensor_name);

    Acquisition? acquisition =
    await rpcClientRap?.SendAsyncLocal<Acquisition, GatewayClient>(
            (rpcClient) => rpcClient.stop_sensor_acquisition(sensor)
    );
  }


  ///// CALLBACKS ////////

  void registerHandler( eHandlerType type ,abSensorHandler handler ) {
    // _handlerQueue.push(eHandlerType.UnActive , handler);
  }

  void OnUnActiveHandler(eHandlerType handler_type){
    // modelFactoryCallbackHandler!(handler_type);
  }

  void OnNetworkUnConnectedHandler(eHandlerType handler_type){
    // modelFactoryCallbackHandler!(handler_type);
  }

  void OnSensorUnConnectedHandler(eHandlerType handler_type){
    // modelFactoryCallbackHandler!(handler_type);
  }

  void OnSensorUnHealthyHandler(eHandlerType handler_type){
    // modelFactoryCallbackHandler!(handler_type);
  }

  void OnExceptionHandler(eHandlerType handler_type){
    // modelFactoryCallbackHandler!(handler_type);
  }

  void OnSnapSuccessFullHandler(eHandlerType handler_type , IModel model){
    // modelFactoryCallbackHandler!(handler_type);
  }

  void OnSnapFailHandler(eHandlerType handler_type){
    // modelFactoryCallbackHandler!(handler_type);
  }

  // IModel? OnModelFactoryCallBack(eHandlerType handler_type) ;


  @override
  Future<bool> action() async {

    // print("OnAction  $tag");

    return await eventTaskQueue.iteratorAndResponse();
  }




}