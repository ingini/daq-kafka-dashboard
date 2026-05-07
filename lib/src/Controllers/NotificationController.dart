
import 'package:daq_dashboard/src/Controllers/TaskController.dart';
import 'package:daq_dashboard/src/container/TimeQueue.dart';
import 'package:daq_dashboard/src/deleGate/DeleGate.dart';
import 'package:daq_dashboard/src/meta/MetaPropertyManager.dart';
import 'package:get/get.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';

class NotificationController extends TaskController {

  final notifications = <_Notification>[].obs;
  var isNotificationOverlayVisible = true.obs;

  TimeQueue<String> _timeQueue = TimeQueue<String>(lifeTime: 15.0);

  NotificationController(int millisecond,)
  :super(null,millisecond)
  {
    startTask();

    _timeQueue.setCompareFunc(
        Func2<String , String , bool> (
                ( src_elements , dest_elements ) {
              if(src_elements.compareTo(dest_elements) == 0)
                return true;

              return false;
            }
        )
    );

  }


  //TODO 이부분은 생성자를 통해서 받는게 유지 보수에 유리하다....
  // 지금은 일단 재정의로 넘어가지만 추후 수정 해야함
  @override
  void setNotificationController()
  {

  }


  @override
  Future<bool> action() async {

    // print("OnAction  $tag");
    _timeQueue.updateQueue();
    return true;

  }

  // NotificationController(super.rpcClientRap = null, super.millisecond);

  void addNotification(String message)
  {

    if( _timeQueue.isContain(message) )
      return;

    _timeQueue.add(message);


    final id = _Notification.nextId++;

    if (_Notification.nextId > 100000) _Notification.nextId = 0;

    final notification = _Notification(id, message);

    notifications.insert(0, notification);


    Future.delayed(Duration(seconds: 3), () {
      removeNotification(id);
    });
  }

  void removeNotification(int id) {
    notifications.removeWhere((n) => n.id == id);
  }


  void toggleNotificationOverlayVisibility() {
    isNotificationOverlayVisible.value = !isNotificationOverlayVisible.value;
    update();
  }

  bool getNotificationOverlayVisibility()
  {
    return  isNotificationOverlayVisible.value ;
  }


  static NotificationController getController()
  {
    return Get.find<NotificationController>(tag: MetaPropertyManager().getMetaProperty(eTags.notification)!.tag_name);
  }

}

class _Notification {
  static int nextId = 0; // 알림의 고유 ID 생성기
  final int id;
  final String message;

  _Notification(this.id, this.message);
}