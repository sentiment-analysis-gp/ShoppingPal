import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_pal/models/product.dart';
import 'package:shopping_pal/models/product_reviews.dart';

import '../models/product_info.dart';
import '../models/product_info.dart';

class Networking {
  static const String NETWORKINGID = "NETWORKING";
  RegExp domainRegexp = RegExp(r'\/{2}.*');
  RegExp pathRegexp = RegExp(r'\/{1}.*');

  Future<ProductInfo> fetchProductData(String productURL) async {
    /*RegExpMatch match = domainRegexp.firstMatch(productURL);
    String domain = match[0].substring(2);
    match = pathRegexp.firstMatch(domain);
    String path = match[0].substring(1);
    domain = domain.substring(0, match.start);*/
    //for Debugging
    // print('$NETWORKINGID URL ' + productURL);
    // print('$NETWORKINGID path ' + path);

    var response = await http.get(Uri.parse("http://3.64.33.37/info"),
        headers: {"product-url": productURL});
    //var reviewResponse = await http.get(Uri.parse("http://3.64.33.37/reviews"),headers: {"product-url": productURL});

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('$NETWORKINGID Object' +
          ProductInfo.fromJson(jsonDecode(response.body)).toString() +
          'Hondaaaaaaaaaaaaaaaa\n');
      return ProductInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load productData');
    }
  }

  Future<ProductReviews> getModelData() async {
    var reviewResponse = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/Ahmad-Montasser/json_placeholder_fake_api/main/reviewsResponse.json"));
    if (reviewResponse.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ProductReviews.fromJson(jsonDecode(reviewResponse.body));
    } else {
      throw Exception('Failed to load Model Data');
    }
  }
}
