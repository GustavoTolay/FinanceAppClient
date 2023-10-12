import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:flutter_app/schemas.dart";

/// GETs all categories & converts them to Objects
Future<List<Category>> getAllCategories() async {
  final url = Uri.parse("http://localhost:8000/categories");
  final response = await http.get(url);
  final List<dynamic> decodedList = jsonDecode(response.body);
  final List<Category> categoryList = [];
  for (var category in decodedList) {
    categoryList.add(
      Category.fromJson(category),
    );
  }
  return categoryList;
}
