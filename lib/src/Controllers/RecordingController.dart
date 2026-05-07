import 'dart:async';
import 'dart:typed_data';

import 'package:daq_dashboard/src/Controllers/SensorController.dart';
import 'package:daq_dashboard/src/Models/IModel.dart';
import 'package:daq_dashboard/src/Models/SensorModel.dart';
import 'package:daq_dashboard/src/State/State.dart';
import 'package:daq_dashboard/src/State/StateManager.dart';
import 'package:daq_dashboard/src/container/RecordingUpdingQueue.dart';
import 'package:daq_dashboard/src/dataObjects/DtoQueue.dart';
import 'package:daq_dashboard/src/dataObjects/IStateVariable.dart';
import 'package:daq_dashboard/src/dataObjects/idto.dart';
import 'package:daq_dashboard/src/meta/AppManager.dart';
import 'package:daq_dashboard/src/meta/recordingDefines.dart';
import 'package:daq_dashboard/src/network/RpcClientRap.dart';
import 'package:daq_dashboard/src/protos/daq-gateway.pbgrpc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import '../deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/State/RecodingState.dart';
import 'dart:io';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:http/http.dart' as http;

import '../protos/daq-service.pb.dart';
import 'package:fixnum/fixnum.dart' as fixnum;

class RecordingController extends SensorController
{

  final StateManager<E_RecordingState, IState<E_RecordingState>> stateManager = StateManager();

  RecordingUploadingQueue<VoiceTagDto>? _uploadingQueue = RecordingUploadingQueue<VoiceTagDto>();

  //getter
  RecordingUploadingQueue<VoiceTagDto> get uploadingQueue => _uploadingQueue!;

  FlutterSoundRecorder? _recorder;

  final int silenceThreshold = 5; // Number of seconds of silence before stopping recording
  int silenceCounter = 0;

  Timer? _silenceTimer;

  recodingProperty? _recordingProperty;

  LastestDtoQueue<VoiceTagDto> _lastestVoiceTagDTOQueue = LastestDtoQueue<VoiceTagDto>();


  VoiceRecordingStateVariable voiceRecordingStateVariable = VoiceRecordingStateVariable();

  RecordingController(
      RpcClientRap<GatewayClient>? rpcClientRap ,
      int millisecond,
      metaProperty taggingMetaProperty ,
      [ bool is_active = false ])
      : super( rpcClientRap , millisecond , taggingMetaProperty , is_active)
  {
    // _uploadingQueue = RecordingUploadingQueue();

    uploadingQueue.setOnRecodingFileUploadingAsyncFunc (
      Action1Async<VoiceTagDto>((VoiceTagDto voiceTagDto) async {
        await _uploadFile(voiceTagDto);
        // print("RecordingController CallBack action : ${voiceTagDto.recordFileFullPath.toString()}");

        // await _uploadFileOnWebserver(voiceTagDto.recordFileFullPath);

      })
    );
    _recordingProperty = recordingDefines.getActiveRecordingProperty();
  }


  // 공통 비동기 초기화 메서드
  @override
  Future<void> initializeAsync() async {

    await _initializeRecorder();
    // 여기에 공통 초기화 작업 추가
    await stateManager.initStateAsync(
        [
          StateRecording( onEnterAsync : ActionAsync( onRecordingEnter ) , onLeaveAsync: ActionAsync( onRecordingLeave)),
          StateIdle(      onEnterAsync : ActionAsync( onIdleEnter )      , onLeaveAsync: ActionAsync( onIdleLeave ))
        ],
        E_RecordingState.Idle ,
        Action1Async((state_id) async {
          voiceRecordingStateVariable.recordingState = state_id;
          update();
        })
    );
  }


  @override
  void processInit()
  {
    _recorder = FlutterSoundRecorder();
    eventTaskQueue.init();

    // _initializeRecorder().then((value) => null);

  }

  E_RecordingState? get recordingState => voiceRecordingStateVariable.recordingState;

  bool get isRecording => voiceRecordingStateVariable.recordingState == E_RecordingState.Recording;

  Future< Uint8List > _readVoiceFile(String fileFullPath ) async {
    // 애플리케이션의 문서 디렉토리를 얻습니다.

    print("path : $fileFullPath");

    // 파일의 전체 경로를 생성합니다.
    final file = File('$fileFullPath');

    // 파일을 바이트 배열로 읽습니다.
    // final bytes = await file.readAsBytes();
    // final Uint8List bt  = await file.readAsBytes();

    // 파일 크기 확인
    if (!await file.exists()) {
      throw Exception("File does not exist");
    }
    final fileLength = await file.length();
    // print('Expected file size: $fileLength bytes');

    // 파일을 스트림으로 읽습니다.
    final List<int> bytes = await file.openRead().expand((element) => element).toList();
    final Uint8List bt = Uint8List.fromList(bytes);

    // 실제 읽은 파일 크기 확인
    // print('Actual file size read: ${bt.length} bytes');
    //
    //
    // // 특정 바이트 범위를 추출합니다. (33~39 바이트)
    // final Uint8List specificBytes = bt.sublist(32, 39); // 0부터 시작하므로 32~38 바이트
    //
    // // 헥사 코드로 변환하여 출력합니다.
    // StringBuffer hexString = StringBuffer();
    // for (var byte in specificBytes) {
    //   hexString.write(byte.toRadixString(16).padLeft(2, '0'));
    //   hexString.write(' ');
    // }
    //
    // print('Hex code of bytes 33 to 39: $hexString');



    return bt;
  }

  Future<void> _uploadFile(VoiceTagDto voiceTagDto) async {

    VoiceTag? voiceTag;

    try
    {
      voiceTag = VoiceTag(
          timestamp: fixnum.Int64(voiceTagDto.timestamp.millisecondsSinceEpoch),
          voice: await _readVoiceFile(voiceTagDto.recordFileFullPath)
      );

      await rpcClientRap?.SendAsyncLocal<void_, GatewayClient>(
              (rpcClient) => rpcClient.add_voice_tag(voiceTag!)
      );

    }
    catch (e)
    {
      print('Error uploading file: $e');
      popupController.setErrorPopup('Error uploading file: $e');
    }
  }

  //
  // Future<void> _uploadFileOnWebserver(String filePath) async {
  //   try
  //   {
  //     var uri = Uri.parse('http://192.168.1.72:5001/upload');
  //     var request = http.MultipartRequest('POST', uri);
  //     request.files.add(await http.MultipartFile.fromPath('file', filePath));
  //     var response = await request.send();
  //
  //     if (response.statusCode == 200)
  //     {
  //       print('File uploaded successfully: $filePath');
  //     }
  //     else
  //     {
  //       print('File upload failed with status: ${response.statusCode}');
  //       popupController.setErrorPopup('File upload failed with status: ${response.statusCode}');
  //     }
  //   }
  //   catch (e)
  //   {
  //     print('Error uploading file: $e');
  //     popupController.setErrorPopup('Error uploading file: $e');
  //   }
  // }


  Future<void> _initializeRecorder() async {
    await Permission.microphone.request();
    await Permission.storage.request();
    await _recorder?.openRecorder();
    Directory? externalDirectory = await getExternalStorageDirectory();
    if (externalDirectory != null) {
      voiceRecordingStateVariable.filePath = externalDirectory.path;
    }
  }



  @override
  Future<bool> action() async {
    super.action();
    await uploadingQueue.action();
    return true;
  }


  // UI

  Future<void> toggleRecordingAsync() async {


    if( stateManager.currentStateId == E_RecordingState.Recording)
    {
      await stopRecordingAsync();
    }
    else
    {
      await startRecordingAsync();
    }

  }


  Future<void> startRecordingAsync() async {
    await stateManager.changeStateAsync(E_RecordingState.Recording);
  }

  Future<void> stopRecordingAsync() async {
    await stateManager.changeStateAsync(E_RecordingState.Idle);
  }
  // UI

  Future<void> onRecordingEnter() async {
    // print("Recording Enter");
    await startRecordingProcess();
  }

  Future<void> onRecordingLeave() async {
    // print("Recording Leave");
    await stopRecordingProcess();


  }

  Future<void> onIdleEnter() async {
    // print("onIdleEnter Enter");
  }

  Future<void> onIdleLeave() async {
    // print("onIdleLeave Leave");
  }



  Future<void> startRecordingProcess() async {

    if(voiceRecordingStateVariable.filePath!.isEmpty)
    {
      return;
    }

    DateTime ts = DateTime.now();
    final fileName = _generateFileName(ts);
    voiceRecordingStateVariable.recordedFileName = fileName; // 파일 이름 저장
    final completeFilePath = '${voiceRecordingStateVariable.filePath}/$fileName';

    _lastestVoiceTagDTOQueue.add(VoiceTagDto(timestamp: ts , recordFileFullPath: completeFilePath));

    print('Starting recording: $completeFilePath');

    try {
      await _recorder?.startRecorder(
        toFile: completeFilePath,
        codec: _recordingProperty!.codec,
        // _recordingProperty.codec,
        sampleRate: 16000,
        bitRate: 16000,
        numChannels: 1,
      );


      silenceCounter = 0;

      _recorder?.setSubscriptionDuration(Duration(milliseconds: 100));
      _recorder?.onProgress!.listen((event) {
        _onProgress(event);
      });
      _startSilenceTimer();
    }
    catch (e) {
      print('Error starting recording: $e');

      popupController.setErrorPopup(e.toString());

      // await stateManager.changeStateAsync(E_RecordingState.Idle);
      stateManager.changeStateReserved(E_RecordingState.Idle);

    }


  }

  void _onProgress(RecordingDisposition disposition)  {
    if(  AppManager.instance.isDebug())
      print('Progress: ${disposition.decibels}');

    if (disposition.decibels != null && disposition.decibels! > -40) {
      silenceCounter = 0;
    }
  }
  void _startSilenceTimer() {
    _silenceTimer?.cancel();
    _silenceTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      silenceCounter++;
      print('Silence counter: $silenceCounter');
      if (silenceCounter >= silenceThreshold) {
        print('Silence detected. Stopping recording');

        // stateManager.changeStateReserved(E_RecordingState.Idle);

        await stopRecordingProcess();
      }
    });
  }


  Future<void> stopRecordingProcess() async {
    await _recorder?.stopRecorder();

    // state.isRecording.value = false;

    _silenceTimer?.cancel();
    print('Stopping recording');

    if (voiceRecordingStateVariable.filePath!.isEmpty || voiceRecordingStateVariable.recordedFileName!.isEmpty)
    {
      print('File path is empty or recordedFileName is empty.');
      popupController.setErrorPopup('File path is empty or recordedFileName is empty.');
      return;
    }

    VoiceTagDto? voiceTagDto = _lastestVoiceTagDTOQueue.pop();

    if(voiceTagDto == null)
    {
      print('voiceTagDto is null');
      popupController.setErrorPopup('File path is empty or recordedFileName is empty.');
      return;
    }

    final completeFilePath = voiceTagDto.recordFileFullPath;

    // print('Complete file path: $completeFilePath');
    final file = File(completeFilePath);
    if (file.existsSync())
    {
      appendUploadingQueue(voiceTagDto);
      // print('File to upload: $completeFilePath');
    }
    else
    {
      print('File path is invalid or file does not exist.');
      popupController.setErrorPopup('File path is invalid or file does not exist.');
    }


  }

  Future<void> appendUploadingQueue(VoiceTagDto dto ) async {
    await uploadingQueue.appendElementAsync(dto);
  }


  String _generateFileName(DateTime ts) {
    final now = ts;
    final formattedDate = "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";
    final formattedTime = "${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";
    return "voice_record_${formattedDate}${formattedTime}.${_recordingProperty!.extension}";
  }


  @override
  SensorModel<IModel>? DefaultModelFactoryMethod() {
    // TODO: implement DefaultModelFactoryMethod
    throw UnimplementedError();
  }

  @override
  SensorModel<IModel>? ModelFactoryMethod() {
    // TODO: implement ModelFactoryMethod
    throw UnimplementedError();
  }



}



