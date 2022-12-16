import 'package:ConsumerApp/src/core/models/payment_mode.dart';
//import 'package:stripe_sdk/stripe_sdk_ui.dart';
import 'package:stripe_sdk/src/models/card.dart';

abstract class IPaymentService {
  Future<List<PaymentMode>> getPaymentMethods();
  Future<bool> buy(StripeCard card, int amount);
}
