



import 'package:daq_dashboard/src/dataObjects/idto.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';

import '../Configure/configUtil.dart';

class ConnectInfoDTO implements  IDTO {

  final String _adress;
  final int _port;

  DaqEdgeDTO _daqEdgeDTO = DaqEdgeDTO();

  String get adress {return _adress;}
  int get port {return _port;}

  ConnectInfoDTO( this._adress , this._port );

  // void SetDaqEdgeDTO( String adress , int port , String user_name , String password )
  // {
  //   _daqEdgeDTO.SetDaqEdgeDTO( adress , port , user_name , password );
  // }

  void SetDaqEdgeDTOFromDTO( DaqEdgeDTO dto )
  {
    _daqEdgeDTO = dto;
  }

  DaqEdgeDTO get daqEdgeDTO {return _daqEdgeDTO;}

}

class DaqEdgeDTO implements IDTO {

  late String _adress;
  late int _port;
  late String _user_name;
  late String _password;
  late String _work_dir;
  late bool   _active;
  late String _docker_compose_file;

  DaqEdgeDTO ();

  // void SetDaqEdgeDTO( String adress , int port , String user_name , String password )
  // {
  //   _adress = adress;
  //   _port = port;
  //   _user_name = user_name;
  //   _password = password;
  // }

  void SetDaqEdgeDTOFromMap( Map<String, dynamic> map )
  {
    _adress = map[ eConfigType.getValue(eConfigKey.daq_edge_address) ];
    _port = map[ eConfigType.getValue(eConfigKey.daq_edge_port) ];
    _user_name = map[eConfigType.getValue(eConfigKey.daq_edge_user_name)];
    _password = map[eConfigType.getValue(eConfigKey.daq_edge_password)];
    _work_dir = map[eConfigType.getValue(eConfigKey.daq_edge_workdir)];
    _active = eBoolExtension.fromStringToBool (map[eConfigType.getValue(eConfigKey.daq_edge_active)]);
    _docker_compose_file = map[eConfigType.getValue(eConfigKey.daq_edge_docker_compose_file)];
  }


  String get adress {return _adress;}
  int get port {return _port;}
  String get user_name {return _user_name;}
  String get password {return _password;}
  String get work_dir {return _work_dir;}
  String get docker_compose_file {return _docker_compose_file;}
  bool get active {return _active;}

  String get docker_compose_file_path {return "$_work_dir/$_docker_compose_file";}

}



class ConnectInfoDtoFactory {

  static Future<ConnectInfoDTO> getConnectInfo  ( ConfigUtil _configUtil ) async
  {
    String adress = await _configUtil.getValue(eConfigKey.server_address);
    int port = await _configUtil.getValue( eConfigKey.port);

    // String daq_edge_address = await _configUtil.getValue( eConfigKey.daq_edge_address);
    // int daq_edge_port = await _configUtil.getValue( eConfigKey.daq_edge_port);
    // String daq_edge_user_name = await _configUtil.getValue( eConfigKey.daq_edge_user_name);
    // String daq_edge_password = await _configUtil.getValue( eConfigKey.daq_edge_password);

    DaqEdgeDTO daq_edge_dto = await _configUtil.getDaqEdgeDto() as DaqEdgeDTO;

    ConnectInfoDTO dto =ConnectInfoDTO( adress , port );

    dto.SetDaqEdgeDTOFromDTO ( daq_edge_dto );

    // dto.SetDaqEdgeDTO( daq_edge_address , daq_edge_port , daq_edge_user_name , daq_edge_password );

    return dto;
  }
}