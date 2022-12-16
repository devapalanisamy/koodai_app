import 'dart:async';

import 'package:ConsumerApp/src/core/models/basket.dart';
import 'package:ConsumerApp/src/core/models/product.dart';

abstract class IBasketService {
  Basket get basket;
  Future<bool> addToBasket(Product product);
  Future<bool> removeFromBasket(Product product);
  bool emptyBasket();
  Stream<Basket> basketStream;
}
