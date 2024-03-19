import 'package:get/get.dart';
import 'package:task_homescreen/screen/list/model/model.dart';

class FavourateController extends GetxController {
  final RxList<Product> favoriteProducts = <Product>[].obs;

  // Add a method to add a product to favorites
  void addToFavorites(Product product) {
    favoriteProducts.add(product.copyWith(isFavorite: true));
  }

  // Add a method to remove a product from favorites
  void removeFromFavorites(int productId) {
    favoriteProducts.removeWhere((product) => product.id == productId);
  }
}
