import 'package:ConsumerApp/src/core/models/product.dart';
import 'package:ConsumerApp/src/core/viewmodels/products_list_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:ConsumerApp/src/ui/widgets/add_to_basket_button.dart';
import 'package:ConsumerApp/src/ui/widgets/remote_image.dart';
import 'package:flutter/material.dart';

class ProductsListView extends StatelessWidget {
  final List<Product> products;
  final String title;
  const ProductsListView({Key key, this.products, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ProductsListViewModel>(
      setupViewModel: (viewmodel) async {
        viewmodel.initialize();
        if (products != null || products.length > 0) {
          viewmodel.products = products;
          return;
        }
        await viewmodel.setProducts();
      },
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            title ?? 'Products',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            color: Colors.lightGreen,
            child: viewModel.products != null && viewModel.products.length > 0
                ? ListView(
                    children: List.generate(
                      viewModel.products.length,
                      (index) => GestureDetector(
                        onTap: () =>
                            viewModel.showProduct(viewModel.products[index]),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            height: 112,
                            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: RemoteImage(
                                    imageUrl:
                                        viewModel.products[index].imageUrl !=
                                                null
                                            ? viewModel.products[index].imageUrl
                                            : ' ',
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          viewModel.products[index].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                          maxLines: 3,
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Text(
                                              '£' +
                                                  viewModel.products[index]
                                                      .sellingPrice
                                                      .toStringAsFixed(2),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Spacer(),
                                            AddToBasketButton(
                                              productCount: viewModel
                                                          .basket.contents[
                                                      viewModel
                                                          .products[index]] ??
                                                  0,
                                              addToBasket: () async {
                                                await viewModel.addToBasket(
                                                    viewModel.products[index]);
                                              },
                                              removeFromBasket: () async {
                                                await viewModel
                                                    .removeFromBasket(viewModel
                                                        .products[index]);
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
                  )
                : Center(
                    child: Text('No products found'),
                  ),
          ),
        ),
      ),
    );
  }
}
