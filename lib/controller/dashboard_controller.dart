import 'package:get/get.dart';

class DashboardController extends GetxController{

  var index = 0.obs;

  void onChange(int index){
    this.index.value = index;
  }
}