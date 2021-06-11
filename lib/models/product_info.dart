import 'package:flutter/material.dart';

class ProductInfo {
  String productURL;
  final String productName;
  final double productPrice;
  final String productImageURL;
  final String productAmazonRating;
  final int numberOfReviews;
  ProductInfo(
      {@required this.productName,
      @required this.productPrice,
      @required this.productAmazonRating,
      @required this.productImageURL,
      this.numberOfReviews});
  Map<String, dynamic> toJson() => {
        'title': productName,
        'price': productPrice,
        'mainImage': productImageURL,
        'rating': productAmazonRating,
        'totalReviews': numberOfReviews,
      };

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      productName: json['title'],
      productPrice: json['price']['current_price'], //ToDo:
      productImageURL: json['mainImage'],
      productAmazonRating: json['rating'],
      numberOfReviews: json['totalReviews'],
    );
  }
  @override
  String toString() {
    return 'Name: $productName\nAmazonRating: $productAmazonRating\nPrice: $productPrice\nImageURL: $productImageURL\nTotalReviews: $numberOfReviews\n';
  }
}
