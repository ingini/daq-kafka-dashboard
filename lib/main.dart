import 'package:daq_dashboard/src/LayOut.dart';
import 'package:daq_dashboard/src/dtos/ConnectInfoDTO.dart';
import 'package:daq_dashboard/src/meta/AppManager.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:daq_dashboard/src/meta/Modes.dart';
import 'package:daq_dashboard/src/Configure/configUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// project imports
import 'package:daq_dashboard/setting.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:wakelock/wakelock.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  Wakelock.enable();

  AppManager.instance.Initialize();
  await AppManager.instance.LoadConfig();

  // RunMode.setMode(eRunMode.Debug);
  // RunMode.setMode(eRunMode.Release);

  // var configUtils = ConfigUtil.instance;
  ConnectInfoDTO? connectInfo =  await ConnectInfoDtoFactory.getConnectInfo( AppManager.instance.configUtil! );

  MetaPropertyManager().Initialize();

  // MetaPropertyManager().TestPrintln();

  await Future.delayed(Duration(milliseconds: 600));

  // var millisec=100;
  var millisec = await AppManager.instance.getInterval();

  await Defines.ControllerRegister( connectInfo! , millisec );


  runApp( ScreenUtilInit(
      designSize: const Size(Defines.const_screen_width, Defines.const_screen_height),
      builder: (context, child) {
        return Dashboard(connectInfo: connectInfo);
      },
  ) );

}


class Dashboard extends StatelessWidget {
  final ConnectInfoDTO? connectInfo;

  const Dashboard({super.key, this.connectInfo});

  @override
  Widget build(BuildContext context) {
    // ScreenUtil 초기화 확인 로그 추가
    print("ScreenUtil initialized with width: ${ScreenUtil().screenWidth.toStringAsFixed(2)}, height: ${ScreenUtil().screenHeight.toStringAsFixed(2)}");

    return  MaterialApp(
      title: Setting.appTitle,
      theme: UITheme.light,
      darkTheme: UITheme.dark,
      themeMode: Setting.theme == 'light' ? ThemeMode.light : ThemeMode.dark,
      home: LayOut(),
    );
  }
}


