



import 'package:daq_dashboard/src/Controllers/RpcRapperController.dart';
import 'package:get/get.dart';

class PopupController extends RpcRapperController{

  var popups = <PopupModel>[].obs;
  PopupController(super.rpcClientRap);



  void setPopup( String title , String message) {
    popups.add(PopupModel(title: title, message: message));
  }

  void setWarringPopup(  String message) {
    popups.add(PopupModel(title: 'Warring', message: message));
  }

  void setErrorPopup(String message) {
    popups.add(PopupModel(title: 'Error', message: message));
  }

  void closePopup(int index) {
    if (index >= 0 && index < popups.length) {
      popups.removeAt(index);
    }
  }


}

class PopupModel {
  String title;
  String message;

  PopupModel({required this.title, required this.message});
}