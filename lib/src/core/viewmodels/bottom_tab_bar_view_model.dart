import 'package:ConsumerApp/src/core/models/basket.dart';
import 'package:ConsumerApp/src/core/services/basket/i_basket_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';

class BottomTabBarViewModel extends BaseViewModel {
  final IBasketService _basketService;

  BottomTabBarViewModel(this._basketService);

  Stream<Basket> get basketStream => _basketService.basketStream;

  int get numberOfItems => _basketService.basket.totalNumberOfItems;

  double get total => _basketService.basket.total();
}
