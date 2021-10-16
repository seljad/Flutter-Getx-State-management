import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shopping/model/item_model.dart';
import 'package:shopping/services/remote_services.dart';
import 'package:shopping/view/signup_page.dart';

class HomeController extends GetxController {
  var categoryItems = List<String>.empty().obs;
  var itemItems = List<ItemModel>.empty().obs;
  var loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchItems();
  }

  void fetchCategories() async {
    var getItems = [
      "electronics",
      "jewelery",
      "men's clothing",
      "women's clothing"
    ];
    categoryItems.value = getItems;
  }

  Future<void> fetchItems() async {
    loading.value = true;
    itemItems.clear();
    var getItems = await RemoteServices.fetchItems();
    loading.value = false;
    if (getItems != null)
      getItems.forEach((item) {
        itemItems.add(ItemModel.fromJson(item));
      });
  }

  ItemModel getDetails(int index){
    return itemItems[index];
  }
}
