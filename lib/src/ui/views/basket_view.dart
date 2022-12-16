import 'package:ConsumerApp/src/core/viewmodels/basket_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:ConsumerApp/src/ui/widgets/add_to_basket_button.dart';
import 'package:ConsumerApp/src/ui/widgets/remote_image.dart';
import 'package:flutter/material.dart';

class BasketView extends StatelessWidget {
  const BasketView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<BasketViewModel>(
      setupViewModel: (viewmodel) async {
        viewmodel.initialize();
      },
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Basket',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          child: viewModel.basket.contents != null &&
                  viewModel.basket.contents.length > 0
              ? SafeArea(
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) =>
                            Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          height: constraints.biggest.height - 80,
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                viewModel.basket.contents.length,
                                (index) => GestureDetector(
                                  onTap: () => viewModel.showProduct(viewModel
                                      .basket.contents.keys
                                      .toList()[index]),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Container(
                                      height: 112,
                                      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: RemoteImage(
                                              imageUrl: viewModel
                                                          .basket.contents.keys
                                                          .toList()[index]
                                                          .imageUrl !=
                                                      null
                                                  ? viewModel
                                                      .basket.contents.keys
                                                      .toList()[index]
                                                      .imageUrl
                                                  : ' ',
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    viewModel
                                                        .basket.contents.keys
                                                        .toList()[index]
                                                        .title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1,
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '£' +
                                                            viewModel.basket
                                                                .contents.keys
                                                                .toList()[index]
                                                                .sellingPrice
                                                                .toStringAsFixed(
                                                                    2),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Spacer(),
                                                      AddToBasketButton(
                                                        productCount: viewModel
                                                                .basket
                                                                .contents[viewModel
                                                                    .basket
                                                                    .contents
                                                                    .keys
                                                                    .toList()[
                                                                index]] ??
                                                            0,
                                                        addToBasket: () async {
                                                          await viewModel
                                                              .addToBasket(viewModel
                                                                      .basket
                                                                      .contents
                                                                      .keys
                                                                      .toList()[
                                                                  index]);
                                                        },
                                                        removeFromBasket:
                                                            () async {
                                                          await viewModel
                                                              .removeFromBasket(
                                                                  viewModel
                                                                      .basket
                                                                      .contents
                                                                      .keys
                                                                      .toList()[index]);
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          height: 80,
                          child: Row(
                            children: [
                              Text(
                                'Total: £' +
                                    viewModel.basket.total().toStringAsFixed(2),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                              Spacer(),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                onPressed: () async {
                                  await viewModel.chooseDeliveryType();
                                },
                                child: Text('Checkout'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Text('Basket is empty'),
                ),
        ),
      ),
    );
  }
}
