import 'package:flutter/material.dart';

class Product {
  String productURL;
  final String productName;
  final int productPrice;
  final String productImageURL;
  final double productAmazonRating;
  final String productModelRating;
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
        'productName': productName,
        'productPrice': productPrice,
        'productModelRating': productModelRating,
        'productAmazonRating': productAmazonRating,
        'productImageURL': productImageURL,
        'productURL': productURL,
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
