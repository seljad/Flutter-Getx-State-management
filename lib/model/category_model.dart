import 'dart:convert';

List<String> categoryModelFromJson(String str) {
  print("++++++++++++++++++");
  var a = json.decode(str) as List;
  print(a[0]);
  return ["a" , "b"];
}

String categoryModelToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
