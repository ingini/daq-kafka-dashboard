import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const double cardBorderRadius = 12;
const double buttonBorderRadius = 3;
const double padding = 8;

double containerSpaceWidth = 0.01.sw;
double containerSpaceCamWidth = 0.003.sw;

double containerSpaceCamMiddle = 0.007.sw;


double containerSpaceHeight = 0.016.sh;
double containerSpaceHeightSm = 0.008.sh;
double containerSpaceHeightMid = 0.015.sh;
double containerSpaceHeightMiddle = 0.010.sh;


SizedBox containerSpace = SizedBox(width: containerSpaceWidth, height: containerSpaceHeight);
SizedBox containerSpaceSm = SizedBox(width: containerSpaceWidth, height: containerSpaceHeightSm);
SizedBox containerSpaceMid = SizedBox(width: containerSpaceWidth, height: containerSpaceHeightMid);
SizedBox containerSpaceCam = SizedBox(width: containerSpaceCamWidth, height: containerSpaceHeight);

SizedBox containerSpaceCamMid = SizedBox(width: containerSpaceCamMiddle, height: containerSpaceHeightMiddle);




const Offset gCamWidgetSize = Offset(308,173);



//------------------------------------------------------------------------------
//
// const ORIN1 = 'orin1_';
// const ORIN2 = 'orin2_';
// const ORIN3 = 'orin3_';
// const X86 = 'x86_';
// const X86DUMP = 'x86dump_';
//
// const USER = 'armstrong';
// const PWD = 'swm.ai';
//
// const UDP = ' udp';
// const TCP = ' tcp';
//
// const RTSP = 'rtsp';
// const LOGGING = 'logging';
// const ALL = '_all.sh';
// const ALL_PY = '_all';
// const SUDO = 'sudo ';
//
// const NET_STATUS_DEAD = 'dead';
// const NET_STATUS_ZOMBIE = 'zombie';
// const NET_STATUS_RUNNING = 'running';
// const NET_STATUS_SLEEPING = 'sleeping';
//
// //------------------------------------------------------------------
// // CAMERA
// //------------------------------------------------------------------
// // GStreamer Sender Info
// const ORIN_DELAY = 1;
// const CAMERA_DELAY = 1;
//
// const ORIN1_CMD_PATH = '/home/armstrong/DAQ/vpu1/camera/';
// const ORIN2_CMD_PATH = '/home/armstrong/DAQ/vpu2/camera/';
// const ORIN3_CMD_PATH = '/home/armstrong/DAQ/vpu3/camera/';
// const ORIN_START_CMD = 'strm_start';
// const ORIN_STOP_CMD = 'strm_stop';
// const ORIN_STATUS_CMD = 'strm_status';
//
// const ORIN1_IP = '192.168.20.124';
// const ORIN2_IP = '192.168.20.125';
// const ORIN3_IP = '192.168.20.126';
//
// const ORIN1_SEND_IP = ' 192.168.10.104';
// const ORIN2_SEND_IP = ' 192.168.10.105';
// const ORIN3_SEND_IP = ' 192.168.10.106';
//
// const ORIN1_SEND_PORT1 = ' 5000';
// const ORIN1_SEND_PORT2 = ' 5001';
//
// const ORIN2_SEND_PORT1 = ' 5100';
// const ORIN2_SEND_PORT2 = ' 5101';
// const ORIN2_SEND_PORT3 = ' 5102';
// const ORIN2_SEND_PORT4 = ' 5103';
//
// const ORIN3_SEND_PORT1 = ' 5200';
// const ORIN3_SEND_PORT2 = ' 5201';
// const ORIN3_SEND_PORT3 = ' 5202';
// const ORIN3_SEND_PORT4 = ' 5203';
//
// const DEVICE0 = ' video0';
// const DEVICE1 = ' video1';
// const DEVICE2 = ' video2';
// const DEVICE3 = ' video3';
//
// // GStreamer Receiver Info
// const X86_CMD_PATH = '/home/armstrong/DAQ/cpu/camera/';
// const X86_IP = '192.168.20.100';
//
// const DAQ1_SEND_IP = ' 192.168.10.124';
// const DAQ2_SEND_IP = ' 192.168.10.125';
// const DAQ3_SEND_IP = ' 192.168.10.126';
//
// const DAQ_START_CMD = 'daq_start';
// const DAQ_STOP_CMD = 'daq_stop';
// const DAQ_STATUS_CMD = 'daq_status';
//
// // RTSP Server - docker compose
// const X86_RTSP_CMD_PATH = '/home/armstrong/DAQ/cpu/mediamtx/';
//
// const RTSP_START_CMD = 'strm_start';
// const RTSP_DELAY = 100000;

//------------------------------------------------------------------
// LIDAR
//------------------------------------------------------------------
//
// const LIDAR_DELAY = 1;
//
// const LIDAR_CMD_PATH = '/home/armstrong/DAQ/cpu/lidar/';
//
// const LIDAR_START_CMD = 'strm_start';
// const LIDAR_STOP_CMD = 'strm_stop';
// const LIDAR_STATUS_CMD = 'strm_status';
//
// const LIDAR_DAQ_START_CMD = 'daq_start';
// const LIDAR_DAQ_STOP_CMD = 'daq_stop';
// const LIDAR_DAQ_STATUS_CMD = 'daq_status';
//
// const LIDAR1_SEND_IP = ' 192.168.20.201';
// const LIDAR2_SEND_IP = ' 192.168.20.202';
// const LIDAR3_SEND_IP = ' 192.168.20.203';
// const LIDAR4_SEND_IP = ' 192.168.20.204';
// const LIDAR5_SEND_IP = ' 192.168.20.110';
// const LIDAR6_SEND_IP = ' 192.168.20.111';
// const LIDAR7_SEND_IP = ' 192.168.20.112';
// const LIDAR8_SEND_IP = ' 192.168.20.113';
//
// const LIDAR1_SEND_PORT = ' 2361';
// const LIDAR2_SEND_PORT = ' 2362';
// const LIDAR3_SEND_PORT = ' 2363';
// const LIDAR4_SEND_PORT = ' 2364';
// const LIDAR5_SEND_PORT = ' 6699';
// const LIDAR6_SEND_PORT = ' 6700';
// const LIDAR7_SEND_PORT = ' 6701';
// const LIDAR8_SEND_PORT = ' 6702';
//
// //------------------------------------------------------------------
// // GNSS
// //------------------------------------------------------------------
//
// const GNSS_DELAY = 1;
//
// const GNSS_CMD_PATH = '/home/armstrong/DAQ/cpu/gnss/';
//
// const GNSS_START_CMD = 'strm_start';
// const GNSS_STOP_CMD = 'strm_stop';
// const GNSS_STATUS_CMD = 'strm_status';
//
// const GNSS_DAQ_START_CMD = 'daq_start';
// const GNSS_DAQ_STOP_CMD = 'daq_stop';
// const GNSS_DAQ_STATUS_CMD = 'daq_status';
//
// const GNSS_SEND_IP = ' 192.168.20.50';
// const GNSS_SEND_PORT = ' 1111';
//
//
// //------------------------------------------------------------------
// // LOGGING Storage
// //------------------------------------------------------------------
//
// const LOGGING_DELAY = 2;
//
// const LOGGING_CMD_PATH = '/home/armstrong/DAQ/cpu/storage/';
// const LOGGING_STATUS_CMD = 'daq_status';
//
//
// //------------------------------------------------------------------
// // LTE & WAN
// //------------------------------------------------------------------
//
// const LTE_IP = '192.168.20.1';
// const WAN_IP = '8.8.8.8';