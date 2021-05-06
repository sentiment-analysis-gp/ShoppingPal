import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_pal/models/product.dart';
import 'package:shopping_pal/screens/shared/custom_drawer.dart';
import 'package:shopping_pal/screens/shared/productcard.dart';
import 'package:http/http.dart';
import 'package:shopping_pal/screens/shared/search_appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> productsHistory = List<Product>();

    List<Map<String, dynamic>> data = ModalRoute.of(context).settings.arguments;
    if (data != null) {
      data.forEach((element) {
        productsHistory.add(Product.fromData(element));
      });
    }

    //if user has clicked the search icon before choose searchfield to display it else display the title of the app

    return Scaffold(
      appBar: SearchAppBar(),
      drawer: CustomDrawer(),
      body: (data == null)
          ? Center(child: Text("Your History is empty"))
          : ListView.builder(
              itemCount: productsHistory.length,
              itemBuilder: (context, index) {
                return ProductCard(product: productsHistory[index]);
              },
            ),
    ); //ToDo: body design
  }
}
