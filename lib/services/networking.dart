import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_pal/models/product_reviews.dart';
import '../models/product_info.dart';
class Networking {
  Future<ProductInfo> fetchProductData(String productURL) async {
    var response = await http.get(Uri.parse("http://3.64.33.37/info"),
        headers: {"product-url": productURL});
    if (response.statusCode == 200) {
      return ProductInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load productData');
    }
  }

  Future<ProductReviews> getModelData(String productURL) async {
    var reviewResponse = await http.get(Uri.parse("http://3.64.33.37/reviews"),
        headers: {"product-url": productURL});
    print(reviewResponse.body);
    if (reviewResponse.statusCode == 200) {
      return ProductReviews.fromJson(jsonDecode(reviewResponse.body));
    } else {
      throw Exception('Failed to load Model Data');
    }
  }
}
