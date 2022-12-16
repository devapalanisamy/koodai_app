import 'package:ConsumerApp/src/core/models/basket.dart';
import 'package:ConsumerApp/src/core/models/product.dart';
import 'package:ConsumerApp/src/core/viewmodels/home_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:ConsumerApp/src/ui/widgets/add_to_basket_button.dart';
import 'package:ConsumerApp/src/ui/widgets/remote_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      setupViewModel: (viewmodel) {
        viewmodel.setBanners();
        viewmodel.initialize();
      },
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: ListView(
          children: [
            Container(
              height: 120,
              color: Colors.lightGreen,
              child: viewModel.banners != null && viewModel.banners.length > 0
                  ? CarouselSlider.builder(
                      itemCount: viewModel.banners.length,
                      itemBuilder: (BuildContext context, int itemIndex) =>
                          Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          //height: 50,
                          padding: EdgeInsets.all(8),
                          child: RemoteImage(
                            imageUrl: viewModel.banners[itemIndex],
                          ),
                        ),
                      ),
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        aspectRatio: 1.0,
                        initialPage: 2,
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text('Featured Products',
                  style: Theme.of(context).textTheme.headline6),
            ),
            if (viewModel.featuredProducts != null &&
                viewModel.featuredProducts.length > 0)
              ProductsTiles(
                products: viewModel.featuredProducts,
                showProduct: viewModel.showProduct,
                addToBasket: viewModel.addToBasket,
                removeFromBasket: viewModel.removeFromBasket,
                basket: viewModel.basket,
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text('Best Selling Products',
                  style: Theme.of(context).textTheme.headline6),
            ),
            if (viewModel.bestSellingProducts != null &&
                viewModel.bestSellingProducts.length > 0)
              ProductsTiles(
                products: viewModel.bestSellingProducts,
                showProduct: viewModel.showProduct,
                addToBasket: viewModel.addToBasket,
                removeFromBasket: viewModel.removeFromBasket,
                basket: viewModel.basket,
              ),
          ],
        ),
      ),
    );
  }
}

class ProductsTiles extends StatelessWidget {
  final List<Product> products;
  final Function(Product) showProduct;
  final Function(Product) addToBasket;
  final Function(Product) removeFromBasket;
  final Basket basket;
  const ProductsTiles({
    Key key,
    @required this.products,
    @required this.showProduct,
    @required this.basket,
    @required this.addToBasket,
    @required this.removeFromBasket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        childAspectRatio: 1.6,
        children: List.generate(products.length, (index) {
          final product = products[index];
          return Container(
            child: LayoutBuilder(
              builder: (context, constraints) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => showProduct(product),
                      child: Center(
                        child: SizedBox(
                          height: constraints.biggest.width - 20,
                          width: constraints.biggest.width - 20,
                          child: RemoteImage(
                            imageUrl: product.imageUrl,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 3, 5, 5),
                        child: Text(
                          product.title,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child:
                          Text('£' + product.sellingPrice.toStringAsFixed(2)),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: AddToBasketButton(
                          productCount: basket.contents[product] ?? 0,
                          addToBasket: () => addToBasket(product),
                          removeFromBasket: () => removeFromBasket(product),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
