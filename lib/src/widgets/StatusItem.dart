
import 'package:daq_dashboard/src/protos/daq-service.pb.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class StatusItem extends StatelessWidget {
  final IconData icon;
  final IconData iconFail;
  final String label;
  final Connection_State? connection_status;
  final Health_Status? health_status;

  StatusItem({required this.icon, required this.iconFail , required this.label, required this.connection_status, required this.health_status });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(width: 17.w),

          Icon(
            icon,
            color: UIComponents.IconColorOnConnectionState(connection_status),
            size: UIComponents.IconSize.sp,
          ),


          SizedBox(width: 25.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: UIComponents.IconColorOnConnectionState(connection_status),fontSize: 30.sp,decoration: TextDecoration.none),
            ),
          ),
          if( health_status != null )
          Icon(
            UIComponents.IconShapeHealth( health_status!),
            color: UIComponents.IconColorHealth( health_status!) ,
            size: UIComponents.IconSize.sp,
          ),

          SizedBox(width: 35.w),
        ],
      ),
    );
  }
}