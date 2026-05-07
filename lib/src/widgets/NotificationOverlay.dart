import 'package:flutter/material.dart';

class NotificationOverlay {
  static final List<_Notification> _notifications = [];
  static int _nextId = 0; // 알림의 고유 ID 생성기

  static void show(BuildContext context, String message) {
    final overlayState = Overlay.of(context);

    // 새 알림의 초기 위치를 설정합니다.
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return _buildOverlayEntry(context, message, 50.0);
      },
    );

    // 고유 ID를 할당합니다.
    final id = _nextId++;
    if( _nextId > 100000)
       _nextId = 0;



    // 새로운 알림을 리스트의 처음에 추가합니다.
    _notifications.insert(0, _Notification(id, message, overlayEntry, 50.0));

    // 새로운 알림을 추가합니다.
    overlayState?.insert(overlayEntry);

    // 새 알림이 추가될 때 기존 알림들의 위치를 업데이트합니다.
    _updatePositions(context);

    // 일정 시간 후에 알림을 제거합니다.
    Future.delayed(Duration(seconds: 3), () {
      _removeOverlay(context , id);
    });
  }

  static void _removeOverlay(BuildContext context , int id) {
    int index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final overlayEntry = _notifications[index].overlayEntry;
      overlayEntry.remove();
      _notifications.removeAt(index);
      _updatePositions(context);
    }
  }

  static void _updatePositions(BuildContext context) {
    for (int i = 0; i < _notifications.length; i++) {
      final notification = _notifications[i];
      final message = notification.message;
      final top = 50.0 + (i * 93.0);

      notification.overlayEntry.remove();
      notification.overlayEntry = OverlayEntry(
        builder: (context) {
          return _buildOverlayEntry(context, message, top);
        },
      );

      Overlay.of(context!)?.insert(notification.overlayEntry);
    }
  }

  static Widget _buildOverlayEntry(BuildContext context, String message, double top) {
    return Positioned(
      top: top,
      right: 10,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          width: 300,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(2),

          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 5, // 붉은 띠의 너비 설정
                height: double.infinity, // 붉은 띠의 높이 설정
                color: Colors.red,
              ),
              SizedBox(width: 8), // 붉은 띠와 텍스트 사이의 간격
              Text(
                message,
                style: TextStyle(color: Colors.black),
                maxLines: null, // 줄바꿈 허용
                overflow: TextOverflow.clip, // 텍스트 넘침 허용
              ),
            ],
          ),
        ),
      ),
    );
  }

  // static Widget _buildOverlayEntry(BuildContext context, String message, double top) {
  //   return Positioned(
  //     top: top,
  //     right: 10,
  //     child: Material(
  //       color: Colors.transparent,
  //       child: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //         decoration: BoxDecoration(
  //           color: Colors.black.withOpacity(0.7),
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: Text(
  //           message,
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //     ),
  //   );
  // }


}

class _Notification {
  final int id;
  String message;
  OverlayEntry overlayEntry;
  double initialTop;

  _Notification(this.id, this.message, this.overlayEntry, this.initialTop);
}
