import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/credit_or_debit_card.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/services/payment/i_payment_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';
//import 'package:stripe_sdk/stripe_sdk_ui.dart';
import 'package:stripe_sdk/src/models/card.dart';

class CreditCardFormViewModel extends BaseViewModel {
  final IPaymentService _paymentService;
  final INavigationService _navigationService;

  CreditCardFormViewModel(
    this._paymentService,
    this._navigationService,
  );

  Future<void> pay(CreditOrDebitCard card) async {
    final StripeCard stripeCard = StripeCard(
      cvc: card.cvv.toString(),
      expMonth: card.expiryMonth,
      expYear: card.expiryYear,
      number: card.cardNumber,
    );
    final result = await _paymentService.buy(stripeCard, 100);
    if (result)
      await _navigationService.pushNamed(
        RoutePaths.orderSummary,
        navigationFlow: NavigationFlow.Default,
      );
  }
}
