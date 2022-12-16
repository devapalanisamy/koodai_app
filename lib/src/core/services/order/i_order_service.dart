import 'package:ConsumerApp/src/core/models/address.dart';
import 'package:ConsumerApp/src/core/models/delivery_type.dart';
import 'package:ConsumerApp/src/core/models/order.dart';
import 'package:ConsumerApp/src/core/models/payment_mode.dart';
import 'package:ConsumerApp/src/core/models/product.dart';

abstract class IOrderService {
  Order order;
  Address shippingAddress;
  Address billingAddress;
  DeliveryType deliveryType;
  PaymentMode paymentMode;
  int numberOfItems;
  double totalCost;
  double deliveryCharge;

  bool setShippingAddress(Address address);
  bool setBillingAddress(Address address);
  bool setPaymentMethod(PaymentMode paymentMode);
  bool setProducts(List<Product> products);
  bool setDeliveryType(DeliveryType deliveryType);
  bool setNumberOfItems(int itemsCount);
  bool setTotalCost(double cost);
  bool setDeliveryCharge(double deliveryCost);

  Future<bool> placeOrder();
}
