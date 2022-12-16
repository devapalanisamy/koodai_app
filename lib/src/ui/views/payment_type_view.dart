import 'package:ConsumerApp/src/core/models/payment_mode.dart';
import 'package:ConsumerApp/src/core/viewmodels/payment_type_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class PaymentTypeView extends StatelessWidget {
  final double total;

  const PaymentTypeView({Key key, this.total}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<PaymentModeViewModel>(
      setupViewModel: (viewmodel) async => await viewmodel.setPaymentModes(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Choose payment type'),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              viewModel.paymentModes != null &&
                      viewModel.paymentModes.length > 0
                  ? Column(
                      children: createRadioListDeliveryTypes(viewModel),
                    )
                  : Padding(
                      padding: EdgeInsets.all(20),
                      child: LinearProgressIndicator(),
                    ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                height: 80,
                child: Row(
                  children: [
                    Text(
                      'Total: £' + total.toStringAsFixed(2),
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    Spacer(),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: viewModel.selectedPaymentMode == null
                          ? null
                          : () async {
                              await viewModel.showNextView();
                            },
                      child: Text('Continue'),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  List<Widget> createRadioListDeliveryTypes(PaymentModeViewModel viewModel) {
    List<Widget> widgets = [];
    for (PaymentMode paymentMode in viewModel.paymentModes) {
      widgets.add(
        RadioListTile(
          value: paymentMode,
          groupValue: viewModel.selectedPaymentMode,
          title: Text(paymentMode.name),
          subtitle: Text(paymentMode.description),
          onChanged: (val) {
            viewModel.setPaymentType(val);
          },
          activeColor: Colors.lightGreen,
          selected: false,
        ),
      );
    }
    return widgets;
  }
}
