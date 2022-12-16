import 'dart:async';

import 'package:ConsumerApp/src/core/models/basket.dart';
import 'package:ConsumerApp/src/core/models/product.dart';
import 'package:ConsumerApp/src/core/services/basket/i_basket_service.dart';

class BasketService extends IBasketService {
  Basket _basket = Basket();

  final StreamController<Basket> controller = StreamController.broadcast();

  @override
  Stream<Basket> get basketStream => controller.stream;

  @override
  Future<bool> addToBasket(Product product) async {
    if (_basket.contents.containsKey(product))
      _basket.contents[product]++;
    else
      _basket.contents[product] = 1;

    controller.add(_basket);
    return true;
  }

  @override
  Future<bool> removeFromBasket(Product product) async {
    if (_basket.contents.containsKey(product)) {
      _basket.contents[product]--;
      if (_basket.contents[product] == 0) _basket.contents.remove(product);
      controller.add(_basket);
    }
    return true;
  }

  @override
  Basket get basket => _basket;

  @override
  bool emptyBasket() {
    _basket = Basket();
    return true;
  }
}
