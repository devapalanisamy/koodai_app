import 'package:ConsumerApp/src/core/models/delivery_type.dart';
import 'package:ConsumerApp/src/core/viewmodels/delivery_type_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class DeliveryTypeView extends StatelessWidget {
  final double total;

  const DeliveryTypeView({Key key, this.total}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<DeliveryTypeViewModel>(
      setupViewModel: (viewmodel) async => await viewmodel.setDeliveryTypes(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Choose delivery type'),
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
              viewModel.deliveryTypes != null &&
                      viewModel.deliveryTypes.length > 0
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
                      onPressed: viewModel.deliveryType == null
                          ? null
                          : () async {
                              await viewModel.continueCheckingOut(total);
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

  List<Widget> createRadioListDeliveryTypes(DeliveryTypeViewModel viewModel) {
    List<Widget> widgets = [];
    for (DeliveryType deliveryType in viewModel.deliveryTypes) {
      widgets.add(
        RadioListTile(
          value: deliveryType,
          groupValue: viewModel.deliveryType,
          title: Text(deliveryType.name),
          subtitle: Text(deliveryType.description),
          onChanged: (val) {
            viewModel.setDeliveryType(val);
          },
          activeColor: Colors.lightGreen,
          selected: false,
        ),
      );
    }
    return widgets;
  }
}
