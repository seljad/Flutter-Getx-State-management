import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:shopping/controller/cart_controller.dart';
import 'package:shopping/controller/home_controller.dart';
import 'package:shopping/view/product_page.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {

  final HomeController controller = Get.find<HomeController>();
  final CartController cc = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome!",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchItems();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Wrap(
            runSpacing: 20,
            children: [wSearch(context), wCategories(), wItemList(context)],
          ),
        ),
      ),
    );
  }

  Widget wSearch(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xffBBDEFB), borderRadius: BorderRadius.circular(20)),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffE3F2FD)),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 16, bottom: 10, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Find the best\nproduct for you",
                    style: TextStyle(
                        color: Color(0xff465bd8),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0.sp),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Feather.search,
                          color: Color(0xff757575),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Search what you need",
                          style: TextStyle(color: Color(0xff757575)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget wCategories() {
    return Obx(() => SizedBox(
          height: 30.0.sp,
          child: ListView.builder(
              itemCount: controller.categoryItems.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xffBDBDBD), width: 0.4),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          controller.categoryItems[index].toString(),
                          style: TextStyle(
                              fontSize: 10.0.sp, color: Color(0xff616161)),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {},
                );
              }),
        ));
  }

  Widget wItemList(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() => controller.loading.value
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: controller.itemItems.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 10),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xFFFFFFFF),
                            const Color(0xB0E7E9E7),
                          ],
                          begin: Alignment(0.2, 0.0),
                          end: Alignment(1.0, 0.0),
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Image.network(
                        controller.itemItems[index].image,
                        width: size.width / 4,
                        height: size.width / 4,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.itemItems[index].title),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.itemItems[index].price.toString() +
                                      " \$",
                                  style: TextStyle(
                                      fontSize: 12.0.sp,
                                      color: Color(0xff465bd8),
                                      fontWeight: FontWeight.bold),
                                ),
                                FloatingActionButton(
                                  backgroundColor: Color(0xff465bd8),
                                  onPressed: () {
                                    cc.addToCart(controller.itemItems[index]);
                                  },
                                  child: Icon(
                                    Foundation.shopping_cart,
                                    size: 20,
                                  ),
                                  mini: true,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  heroTag: null,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.to(()=>ProductPage(), arguments: [index]);
                },
              );
            }));
  }
}
