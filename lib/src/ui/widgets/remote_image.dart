import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';

class RemoteImage extends StatelessWidget {
  final String imageUrl;

  const RemoteImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == ' ')
      Image(
        image: AssetImage('assets/images/placeholder.jpg'),
      );
    return FadeInImage(
      fit: BoxFit.fill,
      image: NetworkImageWithRetry(
        imageUrl,
        fetchStrategy: FetchStrategyBuilder(
                initialPauseBetweenRetries: Duration(seconds: 3))
            .build(),
      ),
      placeholder: AssetImage('assets/images/placeholder.jpg'),
    );
  }
}
