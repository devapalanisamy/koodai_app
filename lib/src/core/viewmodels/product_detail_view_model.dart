import 'dart:async';

import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/basket.dart';
import 'package:ConsumerApp/src/core/models/product.dart';
import 'package:ConsumerApp/src/core/services/basket/i_basket_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';

class ProductDetailViewModel extends BaseViewModel {
  Product product;
  final IBasketService _basketService;

  ProductDetailViewModel(this._basketService);
  Basket get basket => _basketService.basket;

  Stream basketStream;
  StreamSubscription subscription;

  void initialize() {
    basketStream = _basketService.basketStream;
    subscription = basketStream.listen((event) {
      notifyListeners();
    });
  }

  Future<void> addToBasket(Product product) async {
    setState(ViewState.Busy);
    await _basketService.addToBasket(product);
    setState(ViewState.Idle);
  }

  Future<void> removeFromBasket(Product product) async {
    setState(ViewState.Busy);
    await _basketService.removeFromBasket(product);
    setState(ViewState.Idle);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
