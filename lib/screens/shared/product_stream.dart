import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/models/product.dart';
import 'package:shopping_pal/screens/shared/list_products.dart';
import 'package:shopping_pal/screens/shared/product_card.dart';

import 'package:shopping_pal/services/databaseService.dart';

class ProductsStream extends StatelessWidget {
  final DatabaseService _dbService = DatabaseService();
  var stream;
  String dataPath;

  ProductsStream({this.stream, this.dataPath});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: stream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        var productDataRaw = snapshot.data[dataPath];
        final productMap = Map<String, dynamic>.from(productDataRaw);
        List<Product> productCards = [];

        for (var product in productMap.keys) {
          var map = productMap[product];
          Product p = Product.fromJson(map);
          // ProductCard productCard = ProductCard(
          //   product: p,
          //   parentScreen: ParentScreen.history,
          // );
          productCards.add(p);
        }
        return ProductList(
          parentScreen: dataPath == 'searchHistory'
              ? ParentScreen.history
              : ParentScreen.wishList,
          productList: productCards,
        );
      },
    );
  }
}
