import 'package:ConsumerApp/src/core/configs/api_paths.dart';
import 'package:ConsumerApp/src/core/models/menu.dart';
import 'package:ConsumerApp/src/core/models/product.dart';
import 'package:ConsumerApp/src/core/services/products/i_products_service.dart';
import 'package:ConsumerApp/src/core/services/rest_client/i_rest_client.dart';
import 'package:ConsumerApp/src/core/extensions/http_extensions.dart';

class ProductsService extends IProductsService {
  final IRestClient _restClient;

  ProductsService(this._restClient);
  @override
  Future<List<Product>> getProducts() async {
    final response = await _restClient.get(ApiPaths.products);
    if (response.success) {
      return productFromJson(response.body);
    }
    throw Exception(response.reasonPhrase);
  }

  @override
  Future<List<Menu>> getMenu() async {
    final response = await _restClient.get(ApiPaths.menu);
    if (response.success) {
      return menuFromJson(response.body);
    }
    throw Exception(response.reasonPhrase);
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final params = {'name': category};
    final response =
        await _restClient.get(ApiPaths.categoryProducts, parameters: params);
    if (response.success) {
      return productFromJson(response.body);
    }
    throw Exception(response.reasonPhrase);
  }
}
