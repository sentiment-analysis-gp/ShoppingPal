import 'package:flutter/cupertino.dart';

class Product {
  final String productURL;
  final String productName;
  final String productPrice;
  final String productImageURL;
  final String productAmazonRating;
  final String productModelRating;
  Product(
      {@required this.productURL,
      @required this.productName,
      @required this.productPrice,
      this.productAmazonRating,
      this.productImageURL,
      this.productModelRating});
}
