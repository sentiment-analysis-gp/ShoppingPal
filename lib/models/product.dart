import 'package:flutter/material.dart';

class Product {
  String productURL;
  final String productName;
  final int productPrice;
  final String productImageURL;
  final double productAmazonRating;
  final int productModelRating;
  final int numberOfReviews;

  Product(
      {this.productURL,
      @required this.productName,
      @required this.productPrice,
      @required this.productAmazonRating,
      @required this.productImageURL,
      @required this.productModelRating,
      @required this.numberOfReviews});

  Map<String, dynamic> toJson() => {
        'product_URL': productURL,
        'product_title': productName,
        'price': productPrice,
        'product_image': productImageURL,
        'average_rating': productAmazonRating,
        'model_rating': productModelRating,
        'number_of_reviews': numberOfReviews,
      };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productURL: json['product_URL'],
      productName: json['product_title'],
      productPrice: json['price'],
      productImageURL: json['product_image'],
      productAmazonRating: json['average_rating'],
      productModelRating: json['model_rating'],
      numberOfReviews: json['number_of_reviews'],
    );
  }

  @override
  String toString() {
    return 'URL: $productURL \nName: $productName\nAmazonRating: $productAmazonRating\nPrice: $productPrice\nModelRating: $productModelRating\nImageURL: $productImageURL';
  }
}
