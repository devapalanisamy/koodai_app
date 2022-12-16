import 'package:ConsumerApp/src/core/models/menu.dart';
import 'package:ConsumerApp/src/core/models/product.dart';

abstract class IProductsService {
  Future<List<Product>> getProducts();
  Future<List<Product>> getProductsByCategory(String category);
  Future<List<Menu>> getMenu();
}
