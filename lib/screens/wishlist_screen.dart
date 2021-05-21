import 'package:flutter/material.dart';
import 'package:shopping_pal/screens/shared/custom_drawer.dart';
import 'package:shopping_pal/screens/shared/product_stream.dart';
import 'package:shopping_pal/screens/shared/search_appbar.dart';
import 'package:shopping_pal/services/databaseService.dart';

import '../constants.dart';

class WishList extends StatelessWidget {
  final DatabaseService _dbServices = DatabaseService();

  @override
  Widget build(BuildContext context) {
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
              child: ProductsStream(
                stream: _dbServices.getSearchHistoryStream(),
                dataPath: 'wishList',
              ),
            ),
          ],
        ));
  }
}
