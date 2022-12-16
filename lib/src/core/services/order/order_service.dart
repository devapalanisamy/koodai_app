import 'package:ConsumerApp/src/core/configs/api_paths.dart';
import 'package:ConsumerApp/src/core/models/address.dart';
import 'package:ConsumerApp/src/core/models/delivery_type.dart';
import 'package:ConsumerApp/src/core/models/order.dart';
import 'package:ConsumerApp/src/core/models/payment_mode.dart';
import 'package:ConsumerApp/src/core/models/product.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/services/order/i_order_service.dart';
import 'package:ConsumerApp/src/core/services/rest_client/i_rest_client.dart';
import 'package:ConsumerApp/src/core/extensions/http_extensions.dart';

class OrderService extends IOrderService {
  final IRestClient _restClient;
  final INavigationService _navigationService;

  OrderService(
    this._restClient,
    this._navigationService,
  );
  Order get order => _order;
  Order _order = Order();

  @override
  bool setPaymentMethod(PaymentMode selectedPaymentMode) {
    _order.paymentMethodId = selectedPaymentMode.id;
    paymentMode = selectedPaymentMode;
    return true;
  }

  @override
  bool setProducts(List<Product> products) {
    _order.products = products;
    return true;
  }

  @override
  bool setDeliveryType(DeliveryType deliveryType) {
    _order.deliveryTypeId = deliveryType.id;
    deliveryType = deliveryType;
    return true;
  }

  @override
  bool setBillingAddress(Address address) {
    _order.billingAddressId = address.id;
    billingAddress = address;
    return true;
  }

  @override
  bool setShippingAddress(Address address) {
    _order.shippingAddressId = address.id;
    shippingAddress = address;
    return true;
  }

  @override
  bool setNumberOfItems(int itemsCount) {
    numberOfItems = itemsCount;
    return true;
  }

  @override
  bool setTotalCost(double cost) {
    _order.totalAmount = cost;
    totalCost = cost;
    return true;
  }

  @override
  Future<bool> placeOrder() async {
    setDeliveryCharge(0);
    final response = await _restClient.post(
      ApiPaths.orderDetail,
      orderToJson(order),
      isAuthenticationRequired: true,
    );
    if (response.success) {
      return true;
    }
    throw Exception(response.reasonPhrase);
  }

  @override
  bool setDeliveryCharge(double deliveryCost) {
    _order.deliveryCharge = deliveryCost;
    return true;
  }
}
