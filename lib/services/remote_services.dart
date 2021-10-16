import 'dart:async';
import 'package:dio/dio.dart' as dio;
import 'package:shopping/model/item_model.dart';

class RemoteServices {
  static var client = dio.Dio();

  static Future<dynamic> fetchItems() async {
    String theUrl = 'https://fakestoreapi.com/products';
    try {
      dio.Response response = await client
          .get(theUrl,
              options:
                  dio.Options(headers: {'Content-Type': 'application/json'}))
          .timeout(const Duration(seconds: 30));
      dynamic json = response.data;
      if (response.statusCode == 200) {
        return json;
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      return null;
    }
  }
}
