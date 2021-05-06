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

  Product.fromData(Map<String, dynamic> data)
      : productName = data['productName'],
        productPrice = data['productPrice'],
        productModelRating = data['productModelRating'],
        productAmazonRating = data['productAmazonRating'],
        productImageURL = data['productImageURL'],
        productURL = data['productURL'];


  Map<String, dynamic> toJson() => {
      'productName': productName,
      'productPrice': productPrice,
      'productModelRating': productModelRating,
      'productAmazonRating': productAmazonRating,
      'productImageURL': productImageURL,
      'productURL': productURL,
    };
}
