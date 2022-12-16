import 'package:flutter/foundation.dart';

class CreditOrDebitCard {
  final String cardNumber;
  final String cardHolderName;
  final int expiryMonth;
  final int expiryYear;
  final int cvv;

  CreditOrDebitCard({
    @required this.cardNumber,
    @required this.cardHolderName,
    @required this.expiryMonth,
    @required this.expiryYear,
    @required this.cvv,
  });
}
