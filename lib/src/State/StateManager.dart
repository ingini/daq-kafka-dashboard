import 'package:daq_dashboard/src/State/State.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';

class StateMapper<T , K extends IState<T> >  {

  Map< T , K > _stateMap = Map< T , K >();

  void registerState( K state)
  {
    _stateMap[state.stateId] = state;
  }

  K? getState( T state_id )
  {
    if( _stateMap.containsKey(state_id))
    {
      return _stateMap[state_id];
    }

    return null;
  }

  bool isContain( T state_id )
  {
    return _stateMap.containsKey(state_id);
  }
}

class StateManager<T , K extends IState<T> > {

  StateMapper<T , K> _stateMapper = StateMapper<T , K>();

  T? _currentStateId = null;

  // setter getter
  T? get currentStateId => _currentStateId;

  T? _reservedChangeStateId = null;

  Future<void> setCurrentStateId( T? value) async
  {
    if( _onChangeStateAsync != null )
    {
      await _onChangeStateAsync!.Invoke(value!);
    }

    _currentStateId = value;
  }



  Action1Async<T>? _onChangeStateAsync;


  // 변경된 부분: Rx<T?> 타입으로 변경하여 상태 변화를 감지
  // Rx<T?> currentStateId = Rx<T?>(null);


  Future<void> initStateAsync( List <K> states , T initStateId , [Action1Async<T>? onChangeStateAsync] ) async
  {

    _onChangeStateAsync = onChangeStateAsync;

    for( var state in states )
    {
      registerState(state);
    }
    await setCurrentStateAsync(initStateId);
  }

  void registerState( K state)
  {
    _stateMapper.registerState(state);
  }

  Future<void> setCurrentStateAsync( T state_id ) async
  {
    if( _stateMapper.isContain(state_id) )
    {
      // currentStateId.value = state_id;
      await setCurrentStateId(state_id);
      // currentStateId = state_id;
      return;
    }
    throw Exception('stateManager :: Not Exist state id ');
  }

  K? getState( T state_id )
  {
    return _stateMapper.getState(state_id);
  }

  Future<void> OnUpdate<REF_PARAM>( REF_PARAM ref_param ) async {

    await _currentState()?.OnUpdate<REF_PARAM>(ref_param);
  }

  K? _currentState()
  {
    if( currentStateId != null )
    {
      return getState(currentStateId!);
    }
    return null;
  }



  //TODO 이부분은 일단은
  //RecodingController 에서
  // 코덱 미지원 에러시 사용되는데
  // 만약에 더 많은 곳에서 쓸라면
  // ChangeStateQueue 를 만들어서
  // Chenage State 를 처리해줘야 합니다.
  // 현상은 ChangeState 중에 OnEnter OnLeave 중
  // Other State 로 이동 할려는 문제입니다.
  // Queue 에 변화고 싶은 상태를 쌓아 놓는다면
  // 문제가 해결이 될것이고
  // 다만 여러 스테이트가 있을때 비효율 부분은
  // 구현시 확인 및 검증을 해야 합니다.
  void changeStateReserved ( T state_id )
  {
    _reservedChangeStateId = state_id;
  }

  Future<void> _processReservedChangeStateAsync() async
  {
    if( _reservedChangeStateId != null )
    {
      await changeStateAsync(_reservedChangeStateId!);
      _reservedChangeStateId = null;
    }
  }

  Future<void> changeStateAsync ( T state_id ) async
  {

    if( currentStateId == state_id )
    {
      return;
    }

    K? currentState = null;
    K? nextState = null;

    nextState = getState(state_id!);

    if (nextState == null) {
      throw Exception('StateManager :: State with id $state_id does not exist');
    }

    if( currentStateId != null ) {
      // currentState = getState(currentStateId.value!);
      currentState = getState(currentStateId!);
    }

    await currentState?.OnLeaveAsync();
    await nextState.OnEnterAsync();

    await setCurrentStateAsync(state_id);


    await _processReservedChangeStateAsync();

  }

}




