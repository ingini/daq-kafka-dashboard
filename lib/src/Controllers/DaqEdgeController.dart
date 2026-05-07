import 'package:daq_dashboard/src/Controllers/SSHHandlerController.dart';
import 'package:daq_dashboard/src/EventTask/EventTask.dart';
import 'package:daq_dashboard/src/EventTask/EventTaskResponse.dart';
import 'package:daq_dashboard/src/Models/DaqEdgeModel.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/State/DaqEdgeState.dart';
import 'package:daq_dashboard/src/State/State.dart';
import 'package:daq_dashboard/src/State/StateManager.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/dtos/DaqServiceDTO.dart';
import 'package:daq_dashboard/src/meta/AppManager.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/meta/RegExpressDefines.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/network/SSHRap.dart';
import 'package:daq_dashboard/src/network/sshCommander.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';

import 'package:daq_dashboard/src/Models/ModelFactory.dart';
import 'package:daq_dashboard/src/utils/Utils.dart';
import 'package:daq_dashboard/src/meta/daqEdgeDefines.dart' ;
import 'package:daq_dashboard/src/utils/stopWatch.dart';

class DaqEdgeController extends SSHHandlerController {


  final StateManager<E_DaqEdgeState, IState<E_DaqEdgeState>> stateManager = StateManager();

  late SSHDaqEdgeCommander sshDaqEdgeCommander;

  stopWatch _stopWatch = stopWatch();

  DaqEdgeController(
      RpcClientRap<GatewayClient>? rpcClientRap ,
      int millisecond,
      metaProperty taggingMetaProperty ,
      SSHRap sshRap,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty ,
      sshRap ,
      is_active)
  {
    sshDaqEdgeCommander = SSHDaqEdgeCommander(sshRap);
  }


  @override
  void processInit()
  {
    super.processInit();

    eventTaskQueue.init();
    eventTaskQueue.push(EventTaskFactory.CreateEventTask(eProcessingState.Snap,OnProcessSensorSnap,OnSnapSuccess,OnSnapFail));
  }


  // 공통 비동기 초기화 메서드
  @override
  Future<void> initializeAsync() async {


    if(AppManager.instance.daqEdgeIsActive())
    {
      // 여기에 공통 초기화 작업 추가
      await stateManager.initStateAsync(
          [
            StateNone(   onEnterAsync : ActionAsync( onStateNoneEnter ) ,    onLeaveAsync: ActionAsync( onStateNoneLeave ) ,    onUpdateAsync: Action1Async<DaqEdgeModel>( onStateNoneUpdate )) ,
            StatePending(onEnterAsync : ActionAsync( onStatePendingEnter ) , onLeaveAsync: ActionAsync( onStatePendingLeave ) , onUpdateAsync: Action1Async<DaqEdgeModel>(onStatePendingUpdate )),
            StateRunning(onEnterAsync : ActionAsync( onStateRunningEnter ) , onLeaveAsync: ActionAsync( onStateRunningLeave ) , onUpdateAsync: Action1Async<DaqEdgeModel>(onStateRunningUpdate ))
          ],
          E_DaqEdgeState.None  );


    }

  }


  ////////////////////////////////////////////////////////////////////////


  Future<void> onStateNoneEnter() async {
    if(await AppManager.instance.isDebugAsync())
      print("[DEBUG] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStateNone Enter ");
    // await startRecordingProcess();
  }

  Future<void> onStateNoneLeave() async {
    if(await AppManager.instance.isDebugAsync())
      print("[DEBUG] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStateNone Leave");
    // await stopRecordingProcess();
  }

  Future<void> onStateNoneUpdate(DaqEdgeModel ref_model) async {
    if(await AppManager.instance.isDebugAsync())
      print("[DEBUG] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStateNone Update ");

    bool daqRunning = await isDaqServiceRunning();
    if( daqRunning )
    {
      if(await AppManager.instance.isDebugAsync())
        print("[DEBUG] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStateNone Update Goto Running ");
      await stateManager.changeStateAsync(E_DaqEdgeState.Running);
    }
    else
    {
      if(await AppManager.instance.isDebugAsync())
        print("[DEBUG] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStateNone Update Goto Running Pending");
      await stateManager.changeStateAsync(E_DaqEdgeState.Pending);
    }
  }


  Future<bool> isDaqServiceRunning() async
  {
    DaqServiceDTO dto = await DaqServiceDTO.Create(sshDaqEdgeCommander);
    print( dto.toString() );
    return dto.isDaqServiceRunning(daqEdgedefines.daqEdgeTags);
  }


  Future<void> onStatePendingEnter() async {

    // popupController.setWarringPopup(daqEdgedefines.daqEdgeServiceMessage_DockerContainerRestart);
    notificationController.addNotification(daqEdgedefines.daqEdgeServiceMessage_DockerContainerRestart);

    await sshDaqEdgeCommander.docker_compose_restart();
    _stopWatch.start();
  }

  Future<void> onStatePendingLeave() async {
    if(await AppManager.instance.isDebugAsync())
      print("[DEBUG] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStatePending Leave");
  }

  Future<void> onStatePendingUpdate(DaqEdgeModel ref_model) async {
    if(await AppManager.instance.isDebugAsync())
      print("[DEBUG] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStatePending Update ");

    //TODO 이놈이 일정 시간 이상 지속 되면 Fail 로 처리 해야 한다.
    if( await isDaqServiceRunning() )
    {
      await stateManager.changeStateAsync(E_DaqEdgeState.Running);

      return;
    }

    if(_stopWatch.isDurationsecond(daqEdgedefines.daqEdgeServiceMetaServerPendingSencondLimit) )
    {
      await stateManager.changeStateAsync(E_DaqEdgeState.None);
      return;
    }

  }



  Future<void> onStateRunningEnter() async {
    if(await AppManager.instance.isDebugAsync())
      print("[DEBUG] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStateRunning eEnter ");
  }

  Future<void> onStateRunningLeave() async {
    if(await AppManager.instance.isDebugAsync())
      print("[DEBUG] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStateRunning Leave");
  }

  Future<void> onStateRunningUpdate(DaqEdgeModel ref_model) async {
    if(await AppManager.instance.isDebugAsync())
      print("[DEBUG] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStateRunning Update ");

    bool daqRunning = await isDaqServiceRunning();

    if( daqRunning == false )
    {
      if(await AppManager.instance.isDebugAsync())
        print("[DEBUG] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStateRunning Update Goto None ");
      // popupController.setWarringPopup(daqEdgedefines.daqEdgeServiceMessage_DockerContainerDetectedAbnormal);
    notificationController.addNotification(daqEdgedefines.daqEdgeServiceMessage_DockerContainerDetectedAbnormal);
      await stateManager.changeStateAsync(E_DaqEdgeState.None);
    }
    else
    {
      if(await AppManager.instance.isDebugAsync())
        print("[DEBUG] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> onStateRunning Running ");
    }

  }




  /////////////////////////////////////////////////////////////////////////


  Future<void> DaqEdgeStart() async
  {
    if(await AppManager.instance.isDebugAsync())
      print("[DEBUG] DaqEdgeStart ");

    String result = await sshRap.executeCommand("ls -al");
    print(result);

  }

  Future<void> DaqEdgeCheckStatus() async
  {
    if(await AppManager.instance.isDebugAsync())
      print("[DEBUG] DaqEdgeCheckStatus ");

    String result = await sshRap.executeCommand("ls -al");
    print(result);
  }

  @override
  Future<bool> action() async {

    bool ret = await super.action();
    DaqEdgeModel model = ModelFactoryMethod() as DaqEdgeModel;

    try
    {
      await stateManager.OnUpdate(model);
    }
    catch(e)
    {
      print(e);
    }
    finally
    {
      if(await AppManager.instance.isDebugAsync())
        print("[DEBUG] <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< DaqEdgeController::OnProcessSensorSnap <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    }

    return ret;
  }


  Future<EventTaskResponse> OnProcessSensorSnap() async
  {
    if(await AppManager.instance.isDebugAsync())
      print("[DEBUG] ======================== DaqEdgeController::OnProcessSensorSnap =====================================");


    //TODO
    // 여기서 EventTaskResponseResult<DaqEdgeModel>( true , null );
    // 이놈을 전달함
    // 이놈 셋 해서 리턴이 아닌
    // OutPram 으로 받아야 한다.

    // 여기서 DaqEdgeModel 을 넣어주자 ....
    // await stateManager.OnUpdate( DaqEdgeModel );
    //return EventTaskResponseResult<DaqEdgeModel>( true , DaqEdgeModel );
    //
    // DaqEdgeModel model = ModelFactoryMethod() as DaqEdgeModel;
    //
    // try {
    //   await stateManager.OnUpdate(model);
    // }
    // catch(e)
    // {
    //   print(" ************************************* DaqEdgeController::OnProcessSensorSnap <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    //   print(e);
    // }
    // finally
    // {
    //   print(" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< DaqEdgeController::OnProcessSensorSnap <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    // }

    // DaqEdgeModel model = DaqEdgeModel(tag);
    // 결과가 들어갑니다.
    // 서버 기동 경과가 들갑니다.
    // ssh 해서 서버를 돌림
    // await DaqEdgeStart();
    return EventTaskResponseResult<DaqEdgeModel>( true , null );
  }


  @override
  SensorModel<IModel>? DefaultModelFactoryMethod() {

    return ModelFactory.DefaultFactory( DaqEdgeModel(tag) );
  }

  @override
  SensorModel<IModel>? ModelFactoryMethod() {
    return ModelFactory.DefaultFactory( DaqEdgeModel(tag) );
  }

}