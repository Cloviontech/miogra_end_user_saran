import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miogra/core/api_services.dart';
import 'package:miogra/models/shopping/category_model.dart';
import 'package:miogra/models/shopping/get_single_shopproduct.dart';

Future<List<CategoryBasedShop>> fetchProducts(String product) async {
  final response = await http.get(Uri.parse(
      'http://${ApiServices.ipAddress}/category_based_shop/$product'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => CategoryBasedShop.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}




Future<List<GetSingleShopproduct>> fetchSingleProducts(String shopId , String productId) async {
  final response = await http.get(Uri.parse(
      'http://${ApiServices.ipAddress}/get_single_shopproduct/$shopId/$productId'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);

    
    return data.map((json) => GetSingleShopproduct.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
