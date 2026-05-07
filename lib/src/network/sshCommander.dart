import 'package:daq_dashboard/src/meta/AppManager.dart';
import 'package:daq_dashboard/src/meta/RegExpressDefines.dart';
import 'package:daq_dashboard/src/network/SSHRap.dart';

abstract class abSSHCommander {

  final SSHRap _sshRap;

  abSSHCommander( SSHRap sshRap )
  :_sshRap = sshRap;

  SSHRap get sshRap => _sshRap;

}

class SSHDaqEdgeCommander extends abSSHCommander {

  SSHDaqEdgeCommander( SSHRap sshRap )
    :super(sshRap);



  Future<String> docker_compose_up() async {
    if(await AppManager.instance.isDebugAsync())
      print("docker command : ${RegExpressDefines.ShellCommandDockerComposeUP}");

    return await sshRap.executeCommand(RegExpressDefines.ShellCommandDockerComposeUP);
  }



  Future<String> docker_compose_restart() async {
    if(await AppManager.instance.isDebugAsync())
      print("docker command : ${RegExpressDefines.ShellCommandDockerComposeRESTART}");
    String ret = await sshRap.executeCommand(RegExpressDefines.ShellCommandDockerComposeRESTART);
    return ret;

    // await docker_compose_stop();
    // await docker_compose_rm();
    // return await docker_compose_up();

    // print("docker command : ${RegExpressDefines.ShellCommandDockerComposeUP}");
    // return await sshRap.executeCommand(RegExpressDefines.ShellCommandDockerComposeUP);
  }


  Future<String> docker_compose_stop() async {
    print("docker command : ${RegExpressDefines.ShellCommandDockerComposeSTOP}");
    return await sshRap.executeCommand(RegExpressDefines.ShellCommandDockerComposeSTOP);
  }


  Future<String> docker_compose_rm() async {
    if(await AppManager.instance.isDebugAsync())
      print("docker command : ${RegExpressDefines.ShellCommandDockerComposeRM}");
    return await sshRap.executeCommand(RegExpressDefines.ShellCommandDockerComposeRM);
  }

  Future<String> docker_compose_ps() async {
    if(await AppManager.instance.isDebugAsync())
      print("docker command : ${RegExpressDefines.ShellCommandDockerComposePS}");
    return await sshRap.executeCommand(RegExpressDefines.ShellCommandDockerComposePS);
  }



}

