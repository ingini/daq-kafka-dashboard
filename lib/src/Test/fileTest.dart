




import 'dart:io';
import 'dart:typed_data';

Future< Uint8List > readVoiceFile(String fileFullPath ) async {
  // 애플리케이션의 문서 디렉토리를 얻습니다.
  // final directory = await getApplicationDocumentsDirectory();
  // // final path = directory.path;

  print("ssss");


  // 파일의 전체 경로를 생성합니다.
  final file = File('$fileFullPath');

  // 파일을 바이트 배열로 읽습니다.
  // final bytes = await file.readAsBytes();

  final Uint8List bt  = await file.readAsBytes();


  // 특정 바이트 범위를 추출합니다. (33~39 바이트)
  final Uint8List specificBytes = bt.sublist(32, 39); // 0부터 시작하므로 32~38 바이트

  // 헥사 코드로 변환하여 출력합니다.
  StringBuffer hexString = StringBuffer();
  for (var byte in specificBytes) {
    hexString.write(byte.toRadixString(16).padLeft(2, '0'));
    hexString.write(' ');
  }

  print('Hex code of bytes 33 to 39: $hexString');



  return bt;
}



void main() {
  print('Hello, World!');

  // var ts = DateTime.now().millisecondsSinceEpoch;


  readVoiceFile("/storage/emulated/0/Android/data/com.example.daq_dashboard/files/voice_record_20240708102733.m4a");

  var ts = DateTime.now();
  print(ts);
  print(ts.microsecondsSinceEpoch);


}