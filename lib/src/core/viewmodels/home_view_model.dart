import 'dart:async';

import 'package:ConsumerApp/src/core/configs/constants.dart';
import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/basket.dart';
import 'package:ConsumerApp/src/core/models/product.dart';
import 'package:ConsumerApp/src/core/services/app_settings/i_app_settings_service.dart';
import 'package:ConsumerApp/src/core/services/basket/i_basket_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/services/products/i_products_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';

class HomeViewModel extends BaseViewModel {
  final IAppSettingsService _appSettingsService;
  final IProductsService _productsService;
  final INavigationService _navigationService;
  final IBasketService _basketService;
  List<String> banners;
  List<Product> featuredProducts;
  List<Product> bestSellingProducts;

  HomeViewModel(this._appSettingsService, this._productsService,
      this._navigationService, this._basketService);

  Basket get basket => _basketService.basket;

  Stream basketStream;
  StreamSubscription subscription;

  void initialize() {
    basketStream = _basketService.basketStream;
    subscription = basketStream.listen((event) {
      notifyListeners();
    });
  }

  Future<void> setBanners() async {
    setState(ViewState.Busy);
    final settings = await _appSettingsService.getAppSettings();
    banners = settings.banners;
    featuredProducts = await _productsService
        .getProductsByCategory(Constants.featuredProducts);
    bestSellingProducts = await _productsService
        .getProductsByCategory(Constants.bestSellingProducts);
    setState(ViewState.Idle);
  }

  Future<void> showProduct(Product product) async {
    await _navigationService.pushNamed(RoutePaths.productDetail,
        navigationFlow: NavigationFlow.Home, arguments: product);
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
