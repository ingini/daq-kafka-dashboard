





import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartssh2/dartssh2.dart';

Future<void> sshTest(SSHClient client) async {


  String ShellCommandDockerComposeRESTART =   r'''docker compose -f /home/armstrong/DAQ/docker-compose-cpu-t-bench-2.yml restart''';

  try {
    final command = await client.run(ShellCommandDockerComposeRESTART);
    print("Command output: ${utf8.decode(command)}");
  } catch (e) {
    print("Error executing command: $e");
  }

  //
  // final command = await client.run(ShellCommandDockerComposeRESTART);
  //
  // print("asdasdasda");
  //
  // print(utf8.decode( command ));
  //
  // print("asdas11");


}


Future<void> main() async {

  // print("asdas");
  // DaqEdgeDTO dto = DaqEdgeDTO();

  final socket = await SSHSocket.connect('192.168.20.100', 22);
  SSHClient client = SSHClient(socket, username: 'armstrong', onPasswordRequest: () => 'swm.ai');

  final command = await client.run("ls -al");
  print(utf8.decode( command ));
  print("asdas11");
  // String ShellCommandDockerComposeRESTART =   r'''docker compose -f /home/armstrong/DAQ/docker-compose-cpu-t-bench-2.yml restart''';
  // final command = await client.run(ShellCommandDockerComposeRESTART);
  // print("asdasdasda");
  // print(utf8.decode( command ));
  // print("asdas11");

  bool isActionRunning = false;

  Timer.periodic(Duration(milliseconds: 100), (timer) async {

    if (!isActionRunning) {
      isActionRunning = true;

      try {
        await sshTest(client);
      } catch (e) {
        print("err $e");
      } finally {
        isActionRunning = false;
      }

    }

  });


  // client.close();
  // await client.done;


}
