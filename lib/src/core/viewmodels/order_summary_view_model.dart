import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/address.dart';
import 'package:ConsumerApp/src/core/models/order.dart';
import 'package:ConsumerApp/src/core/models/payment_mode.dart';
import 'package:ConsumerApp/src/core/services/basket/i_basket_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/services/order/i_order_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';

class OrderSummaryViewModel extends BaseViewModel {
  final IOrderService _orderService;
  final INavigationService _navigationService;
  final IBasketService _basketService;
  OrderSummaryViewModel(
    this._orderService,
    this._navigationService,
    this._basketService,
  );

  Order get order => _orderService.order;
  int get itemsCount => _orderService.numberOfItems;
  double get total => _orderService.totalCost;
  Address get shippingAddress => _orderService.shippingAddress;
  PaymentMode get selectedPaymentMode => _orderService.paymentMode;

  Future<bool> placeOrder() async {
    final result = await _orderService.placeOrder();
    if (result) {
      _basketService.emptyBasket();
      await _navigationService.pushNamedAndRemoveUntil(RoutePaths.orderSuccess,
          navigationFlow: NavigationFlow.Default);
    }
    return result;
  }
}
