

enum eMediaKey {
  VolumeUp ,
  VolumeDown ,
  ForWard ,
  BackWard ,
  PlayAndPause
}

extension eMediaKeyExtension on eMediaKey {
  int get value {
    switch (this) {
      case eMediaKey.VolumeUp:
        return 24;
      case eMediaKey.VolumeDown:
        return 25;
      case eMediaKey.ForWard:
        return 87;
      case eMediaKey.BackWard:
        return 88;
      case eMediaKey.PlayAndPause:
        return 85;
    }
  }
}


class MediaEventDefines {

  static const String MethodChannel = "media_button_channel";
  static const String MediaButton = "mediaButton";


}

//
// void main() {
//
//   print(eMediaKey.VolumeUp.value);
//   print(eMediaKey.VolumeUp.value);
//   print(eMediaKey.VolumeUp.value);
//
//   if( 24 == eMediaKey.VolumeUp.value){
//     print("VolumeUp");
//   }
//
// }