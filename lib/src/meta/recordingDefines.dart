import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:flutter_sound/flutter_sound.dart';

class recodingProperty extends IProperty {

  final Codec _codec;
  final String _extension;

  recodingProperty( { required Codec codec , required String extension } )
      : _codec = codec,
        _extension = extension;

  Codec get codec => _codec;
  String get extension => _extension;
}


class recordingDefines {

  static  Map<Codec , recodingProperty  > _recordinProperties = {

    Codec.defaultCodec : recodingProperty(codec : Codec.defaultCodec , extension :'' ),
    Codec.aacADTS      : recodingProperty(codec : Codec.aacADTS      , extension :'aac' ),
    Codec.opusOGG      : recodingProperty(codec : Codec.opusOGG      , extension :'ogg' ),
    Codec.opusCAF      : recodingProperty(codec : Codec.opusCAF      , extension :'caf' ),
    Codec.mp3          : recodingProperty(codec : Codec.mp3          , extension :'mp3' ),
    Codec.vorbisOGG    : recodingProperty(codec : Codec.vorbisOGG    , extension :'ogg' ),
    Codec.pcm16        : recodingProperty(codec : Codec.pcm16        , extension :'' ),
    Codec.pcm16WAV     : recodingProperty(codec : Codec.pcm16WAV     , extension :'wav' ),
    Codec.pcm16AIFF    : recodingProperty(codec : Codec.pcm16AIFF    , extension :'aiff' ),
    Codec.pcm16CAF     : recodingProperty(codec : Codec.pcm16CAF     , extension :'caf' ),
    Codec.flac         : recodingProperty(codec : Codec.flac         , extension :'flac' ),
    Codec.aacMP4       : recodingProperty(codec : Codec.aacMP4       , extension :'m4a' ),
    Codec.amrNB        : recodingProperty(codec : Codec.amrNB        , extension :'amr' ),
    Codec.amrWB        : recodingProperty(codec : Codec.amrWB        , extension :'amr' ),
    Codec.pcm8         : recodingProperty(codec : Codec.pcm8         , extension :'' ),
    Codec.pcmFloat32   : recodingProperty(codec : Codec.pcmFloat32   , extension :'' ),
    Codec.pcmWebM      : recodingProperty(codec : Codec.pcmWebM      , extension :'webm' ),
    Codec.opusWebM     : recodingProperty(codec : Codec.opusWebM     , extension :'webm' ),
    Codec.vorbisWebM   : recodingProperty(codec : Codec.vorbisWebM   , extension :'webm' ),

  };

  static recodingProperty getRecordingProperty( Codec codec ) {
    return _recordinProperties[codec]!;
  }

  static String getCodecExtension( Codec codec ) {
    return _recordinProperties[codec]!.extension;
  }

  static recodingProperty getActiveRecordingProperty() {
    return _recordinProperties[Codec.aacMP4]!;
    // return _recordinProperties[Codec.aacADTS]!;
    // return _recordinProperties[Codec.mp3]!;
  }


}

