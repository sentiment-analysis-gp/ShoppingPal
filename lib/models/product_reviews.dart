import 'package:flutter/material.dart';

class ProductReviews {
  final double productModelRating;
  final int numberOfReviews;
  final int numberOfPosReviews;
  final int numberOfNegReviews;
  final int numberOfNeutReviews;
  final String posSample;
  final String negSample;
  final String neutSample;
  ProductReviews(
      {this.numberOfReviews,
      this.productModelRating,
      this.negSample,
      this.neutSample,
      this.numberOfNegReviews,
      this.numberOfNeutReviews,
      this.numberOfPosReviews,
      this.posSample});
  Map<String, dynamic> toJson() => {
        'model_rating': productModelRating,
        'total_count': numberOfReviews,
        'POSITIVE': numberOfPosReviews,
        'NEGATIVE': numberOfNegReviews,
        'NEUTRAL': numberOfNeutReviews,
        'pos_sample': posSample,
        'neg_sample': negSample,
        'neu_sample': neutSample,
      };

  factory ProductReviews.fromJson(Map<String, dynamic> json) {
    return ProductReviews(
      productModelRating: json['model_rating'],
      numberOfReviews: json['total_count'],
      numberOfPosReviews: json['POSITIVE'],
      numberOfNegReviews: json['NEGATIVE'],
      numberOfNeutReviews: json['NEUTRAL'],
      posSample: json['pos_sample'],
      negSample: json['neg_sample'],
      neutSample: json['neu_sample'],
    );
  }
  @override
  String toString() {
    return 'ModelRating: $productModelRating\n';
  }
}
