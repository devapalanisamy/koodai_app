import 'package:ConsumerApp/src/core/models/product.dart';
import 'package:ConsumerApp/src/core/viewmodels/product_detail_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:ConsumerApp/src/ui/widgets/add_to_basket_button.dart';
import 'package:ConsumerApp/src/ui/widgets/remote_image.dart';
import 'package:flutter/material.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;

  const ProductDetailView(
    this.product, {
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<ProductDetailViewModel>(
      setupViewModel: (viewmodel) {
        viewmodel.product = product;
        viewmodel.initialize();
      },
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(viewModel.product.title),
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: RemoteImage(imageUrl: viewModel.product.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    viewModel.product.title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '£${viewModel.product.sellingPrice}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AddToBasketButton(
                    productCount: viewModel.basket.contents[product] ?? 0,
                    addToBasket: () => viewModel.addToBasket(product),
                    removeFromBasket: () => viewModel.removeFromBasket(product),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
