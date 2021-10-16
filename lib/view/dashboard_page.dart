import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shopping/controller/cart_controller.dart';
import 'package:shopping/controller/dashboard_controller.dart';
import 'package:shopping/controller/home_controller.dart';
import 'package:shopping/view/cart_page.dart';
import 'package:shopping/view/home_page.dart';

class DashboardPage extends StatelessWidget {

 final DashboardController controller = Get.put(DashboardController());
 final CartController cc = Get.put(CartController());
 final HomeController hc = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.index.value,
          children: [
            HomePage(),
            CartPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: Color(0xff465bd8),
          items: bottomItems(),
          onTap: controller.onChange,
          currentIndex: controller.index.value,
        ),
      );
    });
  }

  List<BottomNavigationBarItem> bottomItems(){
    return [
      BottomNavigationBarItem(icon: Icon(Feather.home) , label: "Home"),
      BottomNavigationBarItem(icon: Icon(Feather.shopping_cart) , label: "Cart"),
    ];
  }
}
