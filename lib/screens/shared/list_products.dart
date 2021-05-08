import 'package:flutter/material.dart';
import 'package:shopping_pal/models/product.dart';
import 'package:shopping_pal/constants.dart';
import 'productcard.dart';

class ProductList extends StatelessWidget {
  List<Product> productList = List<Product>();
  ParentScreen parentScreen;
  ProductList ({this.productList, this.parentScreen});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: (parentScreen == ParentScreen.wishList)? NeverScrollableScrollPhysics(): ScrollPhysics(),
        shrinkWrap: true,
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return ProductCard(product: productList[index], parentScreen: parentScreen,);
      }
    );
  }
}

