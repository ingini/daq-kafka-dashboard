import 'package:daq_dashboard/src/State/DaqEdgeState.dart';
import 'package:daq_dashboard/src/dataObjects/idto.dart';
import 'package:daq_dashboard/src/meta/RegExpressDefines.dart';
import 'package:daq_dashboard/src/network/SSHRap.dart';
import 'package:daq_dashboard/src/network/sshCommander.dart';
import 'package:daq_dashboard/src/utils/Utils.dart';
import 'package:daq_dashboard/src/meta/daqEdgeDefines.dart' ;



enum eDaqServiceTokenIds
{
  ContainerID,
  Image,
  Command,
  Created,
  Status
}


class DaqServiceElementsDTO implements IDTO {

    List<String> tokens = [];

    DaqServiceElementsDTO( List<String> tokens )
    {
      this.tokens = tokens;
    }

    String get containerID => tokens[eDaqServiceTokenIds.ContainerID.index].toLowerCase();
    String get image => tokens[eDaqServiceTokenIds.Image.index].toLowerCase();
    String get command => tokens[eDaqServiceTokenIds.Command.index].toLowerCase();
    String get created => tokens[eDaqServiceTokenIds.Created.index].toLowerCase();
    String get status => tokens[eDaqServiceTokenIds.Status.index].toLowerCase();

    String getToken(eDaqServiceTokenIds token_id)
    {
      return tokens[token_id.index].toLowerCase();
    }

    E_DaqEdgeState getDockerContainerStatus()
    {
      if(status.startsWith(daqEdgedefines.daqEdgeServiceStatusStartString.toLowerCase()) )
      {
        return E_DaqEdgeState.Running;
      }

      return E_DaqEdgeState.None;
    }

    bool isRunning()
    {
      if(getDockerContainerStatus() == E_DaqEdgeState.Running)
      {
        return true;
      }

      return false;

    }


}


class DaqServiceDTO implements IDTO {

  List<DaqServiceElementsDTO> daqServiceElements = [];


  DaqServiceDTO( List<List<String>> tokens  )
  {
    init(tokens);
  }

  void init( List<List<String>> tokens  )
  {
    for( List<String> token in tokens )
    {
      daqServiceElements.add( DaqServiceElementsDTO(token) );
    }
  }

  static Future<DaqServiceDTO> Create( SSHDaqEdgeCommander sshCommander ) async {

    String mes = await sshCommander.docker_compose_ps();
    List<List<String>> tokens = Utils.regTokenStringLists(mes , RegExpressDefines.RegExpressDockerPS );
    return DaqServiceDTO( tokens);
  }

  DaqServiceElementsDTO? getDaqServiceElementsDTO( eDaqServiceTokenIds token_id , String tag )
  {
    for( DaqServiceElementsDTO element in daqServiceElements )
    {
      String token = element.getToken(token_id);

      if( token.startsWith(tag) )
      {
        return element;
      }

    }
    return null;
  }


  String toString(){
    String str = "";
    for( DaqServiceElementsDTO element in daqServiceElements )
    {
      str += element.containerID + " " + element.image + " " + element.command + " " + element.created + " " + element.status + "\n";
    }
    return str;
  }


  bool isContain( eDaqServiceTokenIds token_id , String tag )
  {
    for( DaqServiceElementsDTO element in daqServiceElements )
    {
      String tagValue = element.getToken(token_id);

      if( element.getToken(token_id).startsWith(tag) )
      {
        return true;
      }
    }
    return false;
  }

  bool isContains( eDaqServiceTokenIds token , List<String> tags )
  {

    List<bool> results = List.filled(tags.length, false);

    for( DaqServiceElementsDTO element in daqServiceElements )
    {
      for( int i = 0 ; i < tags.length ; i++ )
      {
        if( element.getToken(token).startsWith(tags[i]) )
        {
          results[i] = true;
        }
      }

      for( bool result in results )
      {
        if( result == false )
          continue;
      }
      break;
    }

    for( bool result in results )
    {
      if( result == false )
        return false;
    }

    return true;
  }


  bool isDaqServiceRunning( List<String> tags )
  {
    List<bool> results = List.filled(tags.length, false);

    for( int i = 0 ; i < tags.length ; i++ )
    {
      DaqServiceElementsDTO? elementsDTO =  getDaqServiceElementsDTO(eDaqServiceTokenIds.Image, tags[i]);

      if( elementsDTO == null )
        continue;

      if( elementsDTO.isRunning() )
      {
        results[i] = true;
      }

    }


    for( bool result in results )
    {
      if( result == false )
        return false;
    }

    return true;
  }


}