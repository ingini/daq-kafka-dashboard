import 'package:daq_dashboard/src/Models/StorageModel.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:daq_dashboard/src/utils/Utils.dart';
import 'package:daq_dashboard/src/widgets/OutLinedIcon.dart';
import 'package:daq_dashboard/src/widgets/OutLinedText.dart';
import 'package:daq_dashboard/src/widgets/ProgressBar.dart';
import 'package:daq_dashboard/src/widgets/StorageProgressBar.dart';
import 'package:daq_dashboard/src/widgets/StorageStatusWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

// TODO : base 와 extend 분리

// color extend
@immutable
class UIColors extends ThemeExtension<UIColors> {
  static const light = UIColors(
    open: Colors.green,
    closed: Colors.red,
    success: Colors.brown,
    onSuccess: Colors.white,
  );
  static const dark = UIColors(
      open: Colors.white,
      closed: Colors.brown,
      success: Color(0xff6cc067),
      onSuccess: Colors.black
  );

  const UIColors({
    required this.open,
    required this.closed,
    required this.success,
    required this.onSuccess
  });

  final Color? open;
  final Color? closed;
  final Color? success;
  final Color? onSuccess;

  @override
  ThemeExtension<UIColors> copyWith() {
    return UIColors(
        open: open,
        closed: closed,
        success: success,
        onSuccess: onSuccess
    );
  }

  @override
  UIColors lerp(UIColors? other, double t) {
    if (other is! UIColors) {
      return this;
    }
    return UIColors(
      open: Color.lerp(open, other.open, t),
      closed: Color.lerp(closed, other.closed, t),
      success: Color.lerp(success, other.success, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)
    );
  }
}

class UIComponents {


  static const double NotificationWidth =  600;//  500;
  static const double NotificationHeight = 150; //150; //110;
  static const double NotificationHeightGap = NotificationHeight + 3;

  static const double NotificationFontSize = 22; //150; //110;


  static const double IconSize = 45;
  static const double IconBtnSize = 70;

  static const double TextBigSize = 33;

  static const double TextSize = 35;


  static const Color IconColorStatusGood = Color(0xFF00FF0A);
  static const Color IconColorStatusWarn = Color(0xFFFFFF00);
  static const Color IconColorStatusBad = Color(0xFFFF7070);

  static const Color IconColorTrue = Color(0xFFFFFFFF);
  static const Color IconColorFalse = Color(0xFFFF7070);

  static const Color IconColorWhite = Color(0xFFFFFFFF);


  static const Color ColorPrograssBackGround = Color(0xFF183C28);
  static const Color ColorPrograssValueBar   = Color(0xFFEEC643);
  static const Color ColorPrograssBackGroundError = Color(0xFFFF7070);

  static const Color ColorOfficialGreen = Color(0xFF4CAF50);
  static const Color ColorOfficialRed = Color(0xFFFF7070);

  // static const Color IconTextColorTrue = Color(0xFF00FF0A);
  // static const Color IconTextColorFalse = Color(0xFFFF7070);

  static const IconData IconShapeRecordMail = TablerIcons.record_mail;
  static const IconData IconShapeRecordMailOff = TablerIcons.record_mail_off;

  static const IconData IconShapeRecordMike = TablerIcons.microphone;
  static const IconData IconShapeRecordMikeOff = TablerIcons.microphone_off;



  static const IconData IconShapeAt128 = TablerIcons.pizza;
  static const IconData IconShapeRsbp = TablerIcons.rainbow;

  static const IconData IconShapeConnectionStatusGood = TablerIcons.link;
  static const IconData IconShapeConnectionStatusBad = TablerIcons.link_off;

  static const IconData IconShapeHealthStatusGood = TablerIcons.heartbeat;
  static const IconData IconShapeHealthStatusBad = TablerIcons.heart_broken;

  static const IconData IconShapeAcquiring = TablerIcons.database;
  static const IconData IconShapeUnAcquiring = TablerIcons.database_off;

  static const IconData IconShapeSolnsvs = TablerIcons.satellite;
  static const IconData IconShapeUnSolnsvs = TablerIcons.satellite_off;


  static const IconData IconFlip = TablerIcons.flip_vertical;


  static Color IconColor( bool state ) {
    if( state ) {
      return IconColorTrue;
    }
    else {
      return IconColorFalse;
    }
  }

  static Color IconColorOnConnectionState( Connection_State? state ) {
    if( state == Connection_State.CONNECTED ) {
      return IconColorTrue;
    }
    else {
      return IconColorFalse;
    }
  }

  //
  // static Color IconTextColor( bool state ) {
  //   if( state ) {
  //     return IconColorTrue;
  //   }
  //   else {
  //     return IconColorFalse;
  //   }
  // }

  static StatelessWidget storageProgressBar(StorageModel? storageModel)
  {

    if( storageModel?.connection_state == Connection_State.CONNECTED)
    {

      return StorageProgressBar( widgetStatus: eWidgetStatus.Active ,
          proccing_percent1 : storageModel?.getUIRemainStock(),
          bg_color:ColorPrograssBackGround ,
          bar_color:ColorPrograssValueBar );

    }

    return StorageProgressBar( widgetStatus: eWidgetStatus.UnActive ,
        proccing_percent1 : storageModel?.getUIRemainStock(),
        bg_color:ColorPrograssBackGroundError ,
        bar_color:ColorPrograssBackGroundError
    );

  }

  static StatelessWidget storageStatus(StorageModel? storageModel)
  {

    if( storageModel?.connection_state == Connection_State.CONNECTED)
    {
      return StorageStatusWidget( widgetStatus: eWidgetStatus.Active ,
          total_t: storageModel?.getTotalTB() ?? 0,
          used_t: storageModel?.getUsedTB() ?? 0,
          free_t: storageModel?.getFreeTB() ?? 0
      );
    }

    return StorageStatusWidget( widgetStatus: eWidgetStatus.UnActive ,
        total_t:  0,
        used_t:  0,
        free_t:  0
    );

  }

  static StatelessWidget sensorConnectionStateIcon( Connection_State? state ) {
    if( state == Connection_State.CONNECTED ) {
      // return Icon(IconShapeConnectionStatusGood, color: IconColorStatusGood, size: IconSize);

      return OutLinedIcon( icon: IconShapeConnectionStatusGood,
          color: IconColorStatusGood,
          size: IconSize.sp
      );
    }
    else {
      return OutLinedIcon(icon:IconShapeConnectionStatusBad,
          color: IconColorStatusBad,
          size: IconSize.sp);
    }
  }

  static StatelessWidget sensorAcquiringIcon( Acquisition_State? state ) {
    if( state == Acquisition_State.ACQUIRING ) {
      return OutLinedIcon(icon:IconShapeAcquiring, color: IconColorStatusGood, size: IconSize.sp);
    }
    else {
      return OutLinedIcon(icon:IconShapeUnAcquiring, color: IconColorStatusBad, size: IconSize.sp);
    }
  }

  static StatelessWidget imageFlipStatusIcon ( bool is_flip ) {

    return OutLinedIcon(icon:IconFlip, color: is_flip ? IconColorStatusGood : IconColorWhite, size: IconSize.sp);


  }


  static StatelessWidget imageFlipButtonIcon ( bool is_flip ) {

    return Container(
      padding: EdgeInsets.all(8.0.sp),
      decoration: BoxDecoration(
        // color: Colors.white, // 배경색 설정
        border: Border.all(
            color: IconColorWhite ,
            width: 2.w
        ), // 녹색 테두리 추가
        borderRadius: BorderRadius.circular(4.w), // 모서리를 둥글게 처리
      ),
      child: OutLinedIcon(icon:IconFlip, color: is_flip ? IconColorStatusGood : IconColorWhite, size: IconBtnSize.sp),
    );

  }


  static StatelessWidget sensorHealthIcon( Health_Status? statue ) {
    if( statue == Health_Status.GOOD ) {
      return OutLinedIcon(icon:IconShapeHealthStatusGood, color: IconColorStatusGood, size: IconSize.sp);
    }
    else if( statue == Health_Status.WARN )
    {
      return OutLinedIcon(icon:IconShapeHealthStatusBad, color: IconColorStatusWarn, size: IconSize.sp);
    }
    else
    {
      return OutLinedIcon(icon:IconShapeHealthStatusBad, color: IconColorStatusBad, size: IconSize.sp);
    }
  }


  static StatelessWidget acquisitionStartBtn(  ) {

    return acquisitionBtn( IconShapeRecordMail, ColorOfficialGreen );

  }

  static StatelessWidget acquisitionStopBtn(  ) {

    return acquisitionBtn( IconShapeRecordMailOff, ColorOfficialRed );

  }


  static StatelessWidget acquisitionBtn( IconData icon_data , Color bg_color ) {

    return Container(
      decoration: BoxDecoration(
        color: bg_color, // 배경색 설정
        border: Border.all(color: Colors.white, width: 2.w), // 녹색 테두리 추가
        borderRadius: BorderRadius.circular(4), // 모서리를 둥글게 처리
      ),
      child: Center(
        child: Icon(
          icon_data,
          color: Colors.white,
          size: 100.sp,
        ),
      ),
    );

  }

  static StatelessWidget notificationBtn( bool is_visible  ) {

    return Container(
      // decoration: BoxDecoration(
      //   color: bg_color, // 배경색 설정
      //   border: Border.all(color: Colors.white, width: 2.w), // 녹색 테두리 추가
      //   borderRadius: BorderRadius.circular(4), // 모서리를 둥글게 처리
      // ),
      child: Center(
        child: Icon(
          is_visible ? TablerIcons.bell_ringing : TablerIcons.bell_off,
          color: Colors.white,
          size: 50.sp,
        ),
      ),
    );

  }


  static StatelessWidget voiceRecordBtn( bool is_visible  ) {

    return Container(
      // decoration: BoxDecoration(
      //   color: bg_color, // 배경색 설정
      //   border: Border.all(color: Colors.white, width: 2.w), // 녹색 테두리 추가
      //   borderRadius: BorderRadius.circular(4), // 모서리를 둥글게 처리
      // ),
      child: Center(
        child: Icon(
          is_visible ? IconShapeRecordMike : IconShapeRecordMikeOff,
          color: Colors.white,
          size: 80.sp,
        ),
      ),
    );

  }


  static StatelessWidget gnssSolnsvsIcon( int? solnsvs_count ) {
    if( solnsvs_count != null &&  solnsvs_count > 0 )
    {
      return OutLinedIcon(icon:IconShapeSolnsvs, color: IconColorStatusGood, size: IconSize.sp);
    }
    else
    {
      return OutLinedIcon(icon:IconShapeUnSolnsvs, color: IconColorStatusBad, size: IconSize.sp);
    }
  }

  static StatelessWidget gnssSolnsvsText( int? solnsvs_count ) {
    if( solnsvs_count != null &&  solnsvs_count > 0 )
    {
      return OutLinedText(text:solnsvs_count.toString(), color: IconColorStatusGood, size: IconSize.sp);
    }
    else
    {
      return OutLinedText(text:"0", color: IconColorStatusBad, size: IconSize.sp);
    }
  }

  static StatelessWidget gnssSolnsvsLatLonText( double? lat , double? lon ) {

    String displatText = "${lat?.toStringAsFixed(4)} ${lon?.toStringAsFixed(4)}";

    if( lat == null || lon == null )
      displatText = "";

    return Text (
      displatText,
      style: TextStyle(color: Colors.black,fontSize: TextBigSize.sp,decoration: TextDecoration.none),
    );

  }


  static StatelessWidget version() {

    return Text (
      Defines.version,
      style: TextStyle(color: IconColorWhite ,fontSize: TextBigSize.sp ,decoration: TextDecoration.none),
    );

  }


  static StatelessWidget text( String text ,  {Color color = const Color(0xFFBEBFC4)}) {


    return Text (
      text,
      style: TextStyle(color: color,fontSize: TextBigSize.sp ,decoration: TextDecoration.none),
    );

  }

  static StatelessWidget lidarIcon( eLidarType lidar_type ) {

    if( lidar_type == eLidarType.AT128 ) {
      return OutLinedIcon(icon:IconShapeAt128, color: IconColorWhite, size: IconSize.sp);
    }
    else
    {
      return OutLinedIcon(icon:IconShapeRsbp, color: IconColorWhite, size: IconSize.sp);
    }
  }

  static Transform lidarRotateIcon( eLidarType lidar_type , double angle ) {

    IconData iconShape = IconShapeAt128;
    if( lidar_type != eLidarType.AT128 )
      iconShape = IconShapeRsbp;

    return
      Transform.rotate(
        angle: Utils.degreesToRadians( angle ) ,
        child:
          Icon(iconShape, color: IconColorWhite, size: IconSize.sp),
    );


  }


  static Text textWidget ( String? label ) {
    return Text(
      label == null ? "" : label,
      style: TextStyle(color: IconColorTrue,fontSize: TextSize.sp,decoration: TextDecoration.none),
    );
  }

  static Color IconColorHealth( Health_Status status ) {

    if( status == Health_Status.GOOD ) {
      return IconColorStatusGood;
    }
    else if( status == Health_Status.WARN ) {
      return IconColorStatusWarn;
    }
    else if( status == Health_Status.BAAD ) {
      return IconColorStatusBad;
    }
    else {
      return Colors.white;
    }

  }

  static IconData IconShapeHealth( Health_Status status ) {

    if( status == Health_Status.GOOD || status == Health_Status.WARN) {
      return IconShapeHealthStatusGood;
    }
    else if( status == Health_Status.BAAD ) {
      return IconShapeHealthStatusBad;
    }
    else {
      return IconShapeHealthStatusBad;
    }

  }

}



class UITheme {
  static var light = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      UIColors.light,
    ],
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    // TODO:
    // colorScheme: const ColorScheme(
    //     brightness: Brightness.dark,
    //     primary: Color(0xff78919c),
    //     onPrimary: Color(0xffffffff),
    //     secondary: Color(0xff009688),
    //     onSecondary: Color(0xffffffff),
    //     error: Color(0xffd9534f),
    //     onError: Color(0xffffffff),
    //     background: Color(0xff0e1b23),
    //     onBackground: Color(0xffffffff),
    //     surface: Color(0xff0e1b23),
    //     onSurface: Color(0xffffffff)
    // ),
    useMaterial3: true,
  );

  static var dark = ThemeData.dark().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      UIColors.dark,
    ],
    // base color
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xff78919c),
        onPrimary: Color(0xffffffff),
        secondary: Color(0xff009688),
        secondaryContainer: Color(0xff004b44),
        onSecondary: Color(0xffffffff),
        error: Color(0xffd9534f),
        onError: Color(0xffffffff),
        background: Color(0xff0e1b23),
        onBackground: Color(0xffffffff),
        surface: Color(0xff14252f),
        onSurface: Color(0xffffffff)
    )
  );
}
