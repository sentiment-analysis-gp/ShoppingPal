import 'package:flutter/material.dart';

class Product {
  String productURL;
  final String productName;
  final int productPrice;
  final String productImageURL;
  final double productAmazonRating;
  final int productModelRating;
  final int numberOfReviews;
  final int numberOfPosReviews;
  final int numberOfNegReviews;
  final int numberOfNeutReviews;
  final String posSample;
  final String negSample;
  final String neutSample;

  Product(
      {this.productURL,
      @required this.productName,
      @required this.productPrice,
      @required this.productAmazonRating,
      @required this.productImageURL,
      @required this.productModelRating,
      @required this.numberOfReviews,
      this.numberOfNegReviews,
      this.negSample,
      this.neutSample,
      this.numberOfNeutReviews,
      this.numberOfPosReviews,
      this.posSample});

  Map<String, dynamic> toJson() => {
        'product_URL': productURL,
        'product_title': productName,
        'price': productPrice,
        'product_image': productImageURL,
        'average_rating': productAmazonRating,
        'model_rating': productModelRating,
        'number_of_reviews': numberOfReviews,
        'positive_reviews_number': numberOfPosReviews,
        'negative_reviews_number': numberOfNegReviews,
        'neutral_reviews_number': numberOfNeutReviews,
        'positive_review_sample': posSample,
        'negative_review_sample': negSample,
        'neutral_review_sample': neutSample,
      };

  factory Product.fromJson(Map<String, dynamic> json) {
    print(json['positive_reviews_number']);
    print(json['negative_reviews_number']);
    print(json['neutral_reviews_number']);
    print(json['positive_review_sample']);
    print(json['negative_review_sample']);
    print(json['neutral_review_sample']);

    return Product(
      productURL: json['product_URL'],
      productName: json['product_title'],
      productPrice: json['price'],
      productImageURL: json['product_image'],
      productAmazonRating: json['average_rating'],
      productModelRating: json['model_rating'],
      numberOfReviews: json['number_of_reviews'],
      numberOfPosReviews: json['positive_reviews_number'],
      numberOfNegReviews: json['negative_reviews_number'],
      numberOfNeutReviews: json['neutral_reviews_number'],
      posSample: json['positive_review_sample'],
      negSample: json['negative_review_sample'],
      neutSample: json['neutral_review_sample'],
    );
  }

  @override
  String toString() {
    return 'URL: $productURL \nName: $productName\nAmazonRating: $productAmazonRating\nPrice: $productPrice\nModelRating: $productModelRating\nImageURL: $productImageURL';
  }
}
