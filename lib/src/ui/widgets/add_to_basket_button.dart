import 'package:flutter/material.dart';

class AddToBasketButton extends StatelessWidget {
  final int productCount;
  final Future<void> Function() addToBasket;
  final Future<void> Function() removeFromBasket;

  const AddToBasketButton(
      {Key key, this.productCount, this.addToBasket, this.removeFromBasket})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (productCount == 0)
      return GestureDetector(
        onTap: addToBasket,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.secondary,
          ),
          width: 100,
          height: 30,
          child: Center(
              child: Text(
            'Add',
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Theme.of(context).colorScheme.background),
          )),
        ),
      );
    return Container(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Icon(
                Icons.remove,
                color: Theme.of(context).colorScheme.background,
              ),
              width: 30,
              height: 30,
            ),
            onTap: removeFromBasket,
          ),
          Container(
            width: 30,
            height: 30,
            child: Center(child: Text(productCount.toString())),
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.secondary,
              ),
              width: 30,
              height: 30,
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            onTap: addToBasket,
          ),
        ],
      ),
    );
  }
}
