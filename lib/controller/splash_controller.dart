import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shopping/view/signup_page.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    goToNextPage();
  }

  void goToNextPage() async {
    await Future.delayed(Duration(seconds: 2));
    Get.off(() => SignUpPage());
  }
}
