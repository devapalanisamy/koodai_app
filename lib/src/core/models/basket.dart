import 'package:ConsumerApp/src/core/models/product.dart';

class Basket {
  double total() {
    double t = 0.0;
    for (var item in contents.entries) {
      t = t + (item.key.sellingPrice * item.value);
    }
    return t;
  }

  Map<Product, int> contents = Map<Product, int>();
  int get totalNumberOfItems => contents.values.length > 0
      ? contents.values.reduce((value, element) => value + element)
      : 0;

  List<Product> soldProducts() {
    var products = List<Product>();
    for (var item in contents.entries) {
      item.key.soldQuantity = item.value;
      products.add(item.key);
    }
    return products;
  }
}
