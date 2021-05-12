import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/models/product.dart';
import 'package:shopping_pal/screens/shared/list_products.dart';
import 'package:shopping_pal/screens/shared/productcard.dart';

import 'package:shopping_pal/services/databaseService.dart';

class ProductsStream extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: databaseService.getSearchHistoryStream(),
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
        var searchHistoryRaw = snapshot.data['searchHistory'];
        final searchHistoryMap = Map<String, dynamic>.from(searchHistoryRaw);
        List<Product> productCards = [];

        for (var product in searchHistoryMap.keys) {
          var map = searchHistoryMap[product];
          Product p = Product.fromJson(map);
          // ProductCard productCard = ProductCard(
          //   product: p,
          //   parentScreen: ParentScreen.history,
          // );
          productCards.add(p);
        }
        return ProductList(
          parentScreen: ParentScreen.history,
          productList: productCards,
        );
      },
    );
  }
}
