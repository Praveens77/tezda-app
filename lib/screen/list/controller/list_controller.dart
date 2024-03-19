import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:task_homescreen/screen/list/model/model.dart';

class ListController extends GetxController {
  final RxList<Product> products = <Product>[].obs;

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<Product> productList =
            jsonData.map((json) => Product.fromJson(json)).toList();
        products.assignAll(productList);
      } else {
        // ignore: avoid_print
        print(
            'API Error - Status Code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error: $error');
    }
  }

  void toggleFavoriteStatus(int productId) {
    final index = products.indexWhere((product) => product.id == productId);
    if (index != -1) {
      products[index] = products[index].copyWith(
        isFavorite: !products[index].isFavorite,
      );
    }
  }

  void removeFromFavorites(int productId) {
    final index = products.indexWhere((product) => product.id == productId);
    if (index != -1) {
      products[index] = products[index].copyWith(
        isFavorite: false,
      );
    }
  }
}
