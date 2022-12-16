import 'package:ConsumerApp/src/core/models/credit_or_debit_card.dart';
import 'package:ConsumerApp/src/core/utilities/card_utils.dart';
import 'package:ConsumerApp/src/core/viewmodels/credit_card_form_view_model.dart';
import 'package:ConsumerApp/src/ui/utilities/upper_case_text_formatter.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreditCardFormView extends StatefulWidget {
  @override
  _CreditCardFormViewState createState() => _CreditCardFormViewState();
}

class _CreditCardFormViewState extends State<CreditCardFormView> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<CreditCardFormViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Secure Payment'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '#### #### #### ####',
                        filter: {"#": RegExp(r'[0-9]')},
                      ),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      return CardUtils.validateCardNumber(value);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _expiryDateController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                      ),
                    ],
                    decoration: InputDecoration(
                        labelText: 'Expiry Month/Year',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      return CardUtils.validateDate(value);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '####',
                        filter: {"#": RegExp(r'[0-9]')},
                      ),
                    ],
                    decoration: InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      return CardUtils.validateCVV(value);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _cardHolderNameController,
                    keyboardType: TextInputType.name,
                    inputFormatters: [UpperCaseTextFormatter()],
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                        hintText: 'Card Holder Name',
                        labelText: 'Card Holder Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      return CardUtils.validateCardHolderName(value);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          print('valid card entered');
                          final card = CreditOrDebitCard(
                            cardHolderName: _cardHolderNameController.text,
                            cardNumber: CardUtils.getCleanedNumber(
                                _cardNumberController.text),
                            cvv: int.parse(_cvvController.text),
                            expiryMonth: int.parse((_expiryDateController.text
                                .split(new RegExp(r'(\/)'))[0])),
                            expiryYear: int.parse((_expiryDateController.text
                                .split(new RegExp(r'(\/)'))[1])),
                          );
                          viewModel.pay(card);
                        }
                      },
                      child: Text('Continue'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
