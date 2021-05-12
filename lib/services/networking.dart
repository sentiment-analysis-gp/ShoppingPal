import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_pal/models/product.dart';

class Networking {
  static const String NETWORKINGID = "NETWORKING";
  RegExp domainRegexp = RegExp(r'\/{2}.*');
  RegExp pathRegexp = RegExp(r'\/{1}.*');

  Future<Product> fetchProductData(String productURL) async {
    RegExpMatch match = domainRegexp.firstMatch(productURL);
    String domain = match[0].substring(2);
    match = pathRegexp.firstMatch(domain);
    String path = match[0].substring(1);
    domain = domain.substring(0, match.start);
    //for Debugging
    // print('$NETWORKINGID URL ' + productURL);
    // print('$NETWORKINGID path ' + path);
    // print('$NETWORKINGID domain ' + domain);

    var response = await http.get(Uri.https(domain, path));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      print('ok');
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load productData');
    }
  }
}
