import 'package:daq_dashboard/src/meta/AppManager.dart';
import 'package:daq_dashboard/src/utils/Utils.dart';

class RegExpressDefines{

  static String ShellCommandDockerComposePS = r'''docker ps''';


  static String get ShellCommandDockerComposeUP =>      "docker compose -f ${AppManager.instance.daqEdgeDTO?.docker_compose_file_path} up -d";
  static String get ShellCommandDockerComposeSTOP =>    "docker compose -f ${AppManager.instance.daqEdgeDTO?.docker_compose_file_path} stop";
  static String get ShellCommandDockerComposeRM =>      "docker compose -f ${AppManager.instance.daqEdgeDTO?.docker_compose_file_path} rm";
  static String get ShellCommandDockerComposeRESTART => "docker compose -f ${AppManager.instance.daqEdgeDTO?.docker_compose_file_path} restart";

  // static String DaqEdgeDockerPsRegExpress = r'''(\S+)\s+(\S+)\s+"([^"]+)"\s+(\S+\s\S+)\s+([\w\s]+)\s+([\d\.\:\->, ]*)\s*(.*)''';
  // static String RegExpressDockerPS = r'''(\S+)\s+(\S+)\s+"([^"]+)"\s+(\d+\s\S+\s\S+)\s+(\S+\s+\d+\s+\S+)\s''';
  static String RegExpressDockerPS = r'''(\S+)\s+(\S+)\s+"([^"]+)"\s+(\d+\s\S+\s\S+)\s+(Up+\s+\d+\s+\S+|Up+\s+\S+\s+\S+\s+\S+\s+)\s+''';

}


void main() {
  String input = '''CONTAINER ID   IMAGE                                                     COMMAND            CREATED        STATUS        PORTS                                           NAMES
39dfa74bf031   daq-gateway:1.0.0                                         "python main.py"   42 hours ago   Up 42 hours   0.0.0.0:50050->50050/tcp, :::50050->50050/tcp   daq-gateway
5861a9493404   daq-service:1.0.0                                         "python main.py"   42 hours ago   Up 42 hours                                                   daq-service
9179f42c1431   swm/control-platform-node-bridge:1.0.0                    "start-flume"      47 hours ago   Up 47 hours   0.0.0.0:25535->25535/tcp, :::25535->25535/tcp   control-platform-node-bridge
7806a9c4741d   adtc.swm.ai:5000/a50/cpu:dev-x86_64-18.04-20240528_1830   "/bin/bash"        47 hours ago   Up 47 hours                                                   apollo_dev_armstrong
9179f42c1431   swm/control-platform-node-bridge:1.0.0                    "start-flume"      47 hours ago   Up About a minute   0.0.0.0:25535->25535/tcp, :::25535->25535/tcp   control-platform-node-bridge
7806a9c4741d   adtc.swm.ai:5000/a50/cpu:dev-x86_64-18.04-20240528_1830   "/bin/bash"        47 hours ago   Up About a minute                                                   apollo_dev_armstrong
''';
  //
  Utils.regTokenMatchLists(input, RegExpressDefines.RegExpressDockerPS).forEach((match) {

    for (int i = 1; i <= match.groupCount; i++) {
      print('Group $i: ${match.group(i)}');
    }
  });

  Utils.regTokenStringLists(input, RegExpressDefines.RegExpressDockerPS).forEach((match) {

    match.forEach((element) {
      print('element: $element');
    });


  });

  //
  //
  // // String pattern = r'(\S+)\s+(\S+)\s+"([^"]+)"\s+(\S+)\s+(\d+\s+\w+\s+\w+)\s+([\w\s\(\)]+)\s*(.*)';
  // RegExp regExp = RegExp(RegExpressDefines.RegExpressDockerPS, multiLine: true);
  // Iterable<RegExpMatch> matches = regExp.allMatches(input);
  //
  // for (final match in matches) {
  //   for (int i = 1; i <= match.groupCount; i++) {
  //     print('Group $i: ${match.group(i)}');
  //   }
  //   print('---');
  // }
}