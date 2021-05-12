import 'package:flutter/material.dart';
import 'package:shopping_pal/models/product.dart';
import 'package:shopping_pal/screens/shared/custom_drawer.dart';
import 'package:shopping_pal/screens/shared/list_products.dart';
import 'package:shopping_pal/screens/shared/search_appbar.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../constants.dart';

class WishList extends StatelessWidget {
  const WishList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> wishList = List<Product>();

    List<Map<String, dynamic>> data = [
      {
        "productName": "productName",
        "productPrice": r"9999$",
        "productModelRating": "5/5",
        "productAmazonRating": "2/5",
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
      },
      {
        "productName": "productName",
        "productPrice": r"9999$",
        "productModelRating": "5/5",
        "productAmazonRating": "3/5",
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
    if (data != null) {
      data.forEach((element) {});
    }
    return Scaffold(
        appBar: SearchAppBar(),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            SizedBox(
              height: 15.0,
            ),
            Text(
              "Wishlist",
              style: kSecondaryTextStyle.copyWith(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
                child: ProductList(
              productList: wishList,
              parentScreen: ParentScreen.wishList,
            )),
          ],
        ));
  }
}
