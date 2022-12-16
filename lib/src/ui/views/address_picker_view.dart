import 'package:ConsumerApp/src/core/models/address.dart';
import 'package:ConsumerApp/src/core/viewmodels/address_picker_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class AddressPickerView extends StatelessWidget {
  final double total;

  const AddressPickerView({Key key, this.total}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<AddressPickerViewModel>(
      setupViewModel: (viewmodel) async => await viewmodel.setAddresses(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Choose delivery address'),
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
              viewModel.addresses != null && viewModel.addresses.length > 0
                  ? Column(
                      children: createRadioListDeliveryTypes(viewModel),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: LinearProgressIndicator(),
                    ),
              Spacer(),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                height: 80,
                color: Theme.of(context).primaryColor,
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
                      onPressed: viewModel.selectedAddress == null
                          ? null
                          : () async {
                              await viewModel.choosePaymentType(total);
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

  List<Widget> createRadioListDeliveryTypes(AddressPickerViewModel viewModel) {
    List<Widget> widgets = [];
    for (Address address in viewModel.addresses) {
      widgets.add(
        RadioListTile(
          value: address,
          groupValue: viewModel.selectedAddress,
          title: Text(address.toString()),
          onChanged: (val) {
            viewModel.setAddressId(val);
          },
          activeColor: Colors.lightGreen,
          selected: false,
        ),
      );
    }
    return widgets;
  }
}
