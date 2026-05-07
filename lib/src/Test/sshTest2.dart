import 'dart:async';
import 'dart:convert';
import 'package:dartssh2/dartssh2.dart';

Future<void> sshTest(SSHClient client) async {
  String shellCommandDockerComposeRestart = r'''docker compose -f /home/armstrong/DAQ/docker-compose-cpu-t-bench-2.yml restart''';

  try {
    final command = await client.run(shellCommandDockerComposeRestart);
    print("Command output: ${utf8.decode(command)}");
  } catch (e) {
    print("Error executing command: $e");
  }
}

Future<SSHClient> createSSHClient() async {
  final socket = await SSHSocket.connect('192.168.20.100', 22);
  SSHClient client = SSHClient(
    socket,
    username: 'armstrong',
    onPasswordRequest: () => 'swm.ai', // Ensure the password is correct
  );
  return client;
}

Future<void> main() async {
  SSHClient client;

  try {
    client = await createSSHClient();
  } catch (e) {
    print("Failed to create SSH client: $e");
    return;
  }

  bool isActionRunning = false;

  Timer.periodic(Duration(seconds: 1), (timer) async {
    if (isActionRunning) {
      return;
    }

    isActionRunning = true;

    try {
      await sshTest(client);
    } catch (e) {
      print("Error in periodic task: $e");
    } finally {
      isActionRunning = false;
    }
  });

  // Ensure the main function does not exit immediately
  await Future.delayed(Duration(minutes: 1));

  // Clean up resources and cancel the timer when done
  client.close();
  await client.done;
}
