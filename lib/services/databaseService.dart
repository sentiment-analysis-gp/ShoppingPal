import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'dart:convert';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> productJson = [
    {
      "productName": "productName",
      "productPrice": r"9999$",
      "productModelRating": "5/5",
      "productAmazonRating": "5/5",
      "productImageURL": "productImageURL",
      "productURL": "productURL"
    },
    {
      "productName": "productName",
      "productPrice": r"9999$",
      "productModelRating": "5/5",
      "productAmazonRating": "5/5",
      "productImageURL": "productImageURL",
      "productURL": "productURL"
    }
  ];

  Future<List<Map<String, dynamic>>> getProduct() async {
    Response result = await get(
        Uri.https("mocki.io", "v1/b4544ffb-219f-4d24-9613-9fda0baee216"));
    print(jsonDecode(result.body));
    return productJson;
  }
}
