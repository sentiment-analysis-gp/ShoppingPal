import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';

import 'package:shopping_pal/screens/shared/custom_drawer.dart';
import 'package:shopping_pal/services/databaseService.dart';
import 'shared/product_stream.dart';
import 'package:shopping_pal/screens/shared/search_appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _dbServices = DatabaseService();

  @override
  Widget build(BuildContext context) {
    //if user has clicked the search icon before choose search field to display it else display the title of the app

    return Scaffold(
        appBar: SearchAppBar(),
        drawer: CustomDrawer(),
        //backgroundColor: Colors.purple[50],
        body: Column(
          children: [
            SizedBox(
              height: 15.0,
            ),
            Text(
              "Search History",
              style: kSecondaryTextStyle.copyWith(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Center(
                child: ProductsStream(
                  stream: _dbServices.getSearchHistoryStream(),
                  dataPath: 'searchHistory',
                ),
              ),
            ),
          ],
        ));
  }
}
