


import 'package:flutter/material.dart';

enum eRunMode {
  Debug,
  Release,
}

extension eRunModeExtension on eRunMode {
  static const Map<eRunMode, String> _values = {
    eRunMode.Debug: "debug",
    eRunMode.Release: "release",
  };


  static eRunMode fromString(String value) {

    for (var entry in _values.entries) {
      if (entry.value.toLowerCase() == value.toLowerCase()) {
        return entry.key;
      }
    }
    return eRunMode.Debug;

  }
}
//
// class RunMode {
//   static eRunMode mode = eRunMode.Debug;
//
//   static void setMode(eRunMode mode) {
//     RunMode.mode = mode;
//   }
//
//   static bool IsDebug() {
//     return mode == eRunMode.Debug;
//   }
//
//   //color: RunMode.IsDebug() ? Colors.red : null ,
//   static Color? IsDebugColor(Color color ) {
//     return mode == eRunMode.Debug ? color : null;
//   }
//
//   static bool IsRelease() {
//     return mode == eRunMode.Release;
//   }
// }

//
// void main() {
//   eRunMode mode = eRunModeExtension.fromString("debug");
//   print('Enum for "debug": $mode'); // Outputs: Enum for "debug": eRunMode.Debug
//
//   mode = eRunModeExtension.fromString("release");
//   print('Enum for "release": $mode'); // Outputs: Enum for "release": eRunMode.Release
//
//   String modeValue = mode.toString();
//   print('String value for $mode: $modeValue'); // Outputs: String value for eRunMode.Release: release
// }
