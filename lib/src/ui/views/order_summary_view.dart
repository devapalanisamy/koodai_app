import 'package:ConsumerApp/src/core/models/product.dart';
import 'package:ConsumerApp/src/core/viewmodels/order_summary_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class OrderSummaryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<OrderSummaryViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Summary'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpansionTile(
                    tilePadding: EdgeInsets.only(left: 8),
                    title: Row(
                      children: [
                        Text(
                          'Basket Items',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Spacer(),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.secondaryVariant,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                              child: Text(
                            viewModel.itemsCount.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                          )),
                        )
                      ],
                    ),
                    children: getProductsTiles(viewModel.order.products),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Total items'),
                              Spacer(),
                              Text(
                                viewModel.itemsCount.toString(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Delivery charge'),
                              Spacer(),
                              Text(
                                'FREE',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Total (Including VAT)'),
                              Spacer(),
                              Text(
                                '£' + viewModel.total.toStringAsFixed(2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ShippingAddressWidget(
                    address: viewModel.shippingAddress.toString(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Payment Details',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Payment Method'),
                              Spacer(),
                              Text(viewModel.selectedPaymentMode.name)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          height: 80,
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              Spacer(),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onPressed: () async {
                  await viewModel.placeOrder();
                },
                child: Text('Place order'),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getProductsTiles(List<Product> products) {
    return List<Widget>.from(products.map((e) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 5, 24, 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.title),
                  Row(
                    children: [
                      Text(e.soldQuantity.toString()),
                      Text(' x '),
                      Text('£' + e.sellingPrice.toStringAsFixed(2)),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Text('£' + (e.sellingPrice * e.soldQuantity).toStringAsFixed(2)),
            ],
          ),
        )));
  }
}

class ShippingAddressWidget extends StatelessWidget {
  const ShippingAddressWidget({
    Key key,
    this.address,
  }) : super(key: key);
  final String address;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Shipping Address',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(address),
          ),
        ),
      ],
    );
  }
}
