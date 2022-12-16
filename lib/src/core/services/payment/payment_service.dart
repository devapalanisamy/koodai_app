import 'dart:convert';

import 'package:ConsumerApp/src/core/configs/api_paths.dart';
import 'package:ConsumerApp/src/core/extensions/http_extensions.dart';
import 'package:ConsumerApp/src/core/models/payment_mode.dart';
import 'package:ConsumerApp/src/core/models/stripe_secret.dart';
import 'package:ConsumerApp/src/core/services/dialog/i_dialog_service.dart';
import 'package:ConsumerApp/src/core/services/payment/i_payment_service.dart';
import 'package:ConsumerApp/src/core/services/rest_client/i_rest_client.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/src/models/card.dart';

class PaymentService extends IPaymentService {
  final IRestClient _restClient;
  final IDialogService _dialogService;

  PaymentService(this._restClient, this._dialogService);

  @override
  Future<List<PaymentMode>> getPaymentMethods() async {
    final response = await _restClient.get(
      ApiPaths.paymentMethods,
      isAuthenticationRequired: true,
    );
    if (response.success) {
      return paymentModesFromJson(response.body);
    }
    throw Exception(response.reasonPhrase);
  }

  final Stripe stripe = Stripe(
    "pk_test_51HkaM0BxE6mP45bNRj5FO81I98QWsol9cMW0SXTe8ZEj6x4QdHTkfG38iDwiQ76Mai02NqwkCk51CzpgQNf3e1Xb005pWVBa5B", //Your Publishable Key
    // stripeAccount:
    //     "acct_1G...", //Merchant Connected Account ID. It is the same ID set on server-side.
    returnUrlForSca:
        "consumerapp://com.halo.consumerapp/stripe/redirect", //Return URL for SCA
  );

  Future<String> postCreatePaymentIntent(
      String email, String paymentMethodId, int amount) async {
    StripeSecret secret;

    final res = await _restClient.post(
      'api/Payments',
      jsonEncode(<String, dynamic>{
        'amount': amount,
        'description': paymentMethodId,
        'paymentMethod': paymentMethodId,
      }),
      isAuthenticationRequired: true,
    );

    secret = stripeSecretFromJson(res.body);
    return secret.clientSecret;
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      StripeCard stripeCard, String customerEmail, int amount) async {
    String clientSecret;
    Map<String, dynamic> paymentIntentRes, paymentMethod;
    try {
      paymentMethod = await stripe.api.createPaymentMethodFromCard(stripeCard);
      clientSecret = await postCreatePaymentIntent(
          customerEmail, paymentMethod['id'], amount);
      paymentIntentRes = await stripe.api.retrievePaymentIntent(clientSecret);
    } catch (e) {
      print("ERROR_CreatePaymentIntentAndSubmit: $e");
      await _dialogService.showDefaultAlert(
        title: 'Error',
        message: 'Something went wrong.',
      );
    }
    return paymentIntentRes;
  }

  Future<Map<String, dynamic>> confirmPayment3DSecure(
      String clientSecret, String paymentMethodId) async {
    Map<String, dynamic> paymentIntentRes_3dSecure;
    try {
      await stripe.confirmPayment(clientSecret,
          paymentMethodId: paymentMethodId);
      paymentIntentRes_3dSecure =
          await stripe.api.retrievePaymentIntent(clientSecret);
    } catch (e) {
      print("ERROR_ConfirmPayment3DSecure: $e");
      await _dialogService.showDefaultAlert(
        title: 'Error',
        message: 'Something went wrong.',
      );
    }
    return paymentIntentRes_3dSecure;
  }

  @override
  Future<bool> buy(StripeCard card, int amount) async {
    final StripeCard stripeCard = card;
    final String customerEmail =
        'swat.deva22@gmail.com'; //TODO - remove it and get actual email

    if (!stripeCard.validateCVC()) {
      await _dialogService.showDefaultAlert(
        title: 'Error',
        message: 'CVC not valid.',
      );
      return false;
    }
    if (!stripeCard.validateDate()) {
      await _dialogService.showDefaultAlert(
        title: 'Error',
        message: 'Date not valid.',
      );
      return false;
    }
    if (!stripeCard.validateNumber()) {
      await _dialogService.showDefaultAlert(
        title: 'Error',
        message: 'Number not valid.',
      );
      return false;
    }

    Map<String, dynamic> paymentIntentRes =
        await createPaymentIntent(stripeCard, customerEmail, amount);
    String clientSecret = paymentIntentRes['client_secret'];
    String paymentMethodId = paymentIntentRes['payment_method'];
    String status = paymentIntentRes['status'];

    if (status == 'requires_confirmation') //3D secure is enable in this card
      paymentIntentRes =
          await confirmPayment3DSecure(clientSecret, paymentMethodId);

    if (paymentIntentRes['status'] != 'succeeded') {
      await _dialogService.showDefaultAlert(
        title: 'Warning',
        message: 'Canceled Transaction.',
      );
      return false;
    }

    if (paymentIntentRes['status'] == 'succeeded') {
      await _dialogService.showDefaultAlert(
          title: 'Success', message: 'Thanks for buying!');
      return true;
    }
    await _dialogService.showDefaultAlert(
        title: 'Warning',
        message: 'Transaction rejected.\nSomething went wrong');
    return false;
  }
}
