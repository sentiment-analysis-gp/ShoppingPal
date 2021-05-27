import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:flutter/services.dart';
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

  RoundedRectangleBorder popUpButtonStyle = RoundedRectangleBorder(
    side: BorderSide(
      width: 3,
      color: kSecondaryColor,
    ),
    borderRadius: BorderRadius.circular(5),
  );

  @override
  Widget build(BuildContext context) {
    //if user has clicked the search icon before choose search field to display it else display the title of the app

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                style:
                kMainTextStyle.copyWith(color: kPrimaryColor, fontSize: 35),
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
          )),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 3,
            color: kSecondaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        titleTextStyle: kMainTextStyle.copyWith(
          color: kPrimaryColor,
        ),
        title: Column(
          children: [
            Text('Are you sure?'),
            Divider(
              thickness: 3,
              color: kSecondaryColor,
            ),
          ],
        ),
        content: Text(
          'Do you want to exit ?',
          textAlign: TextAlign.center,
          style: kMainTextStyle.copyWith(color: kPrimaryColor),
        ),
        actions: <Widget>[
          RaisedButton(
            color: Colors.white,
            shape: popUpButtonStyle,
            onPressed: () => SystemNavigator.pop(),
            child: Text(
              'Yes',
              style: kMainTextStyle.copyWith(
                  color: kSecondaryColor, fontSize: 16),
            ),
          ),
          RaisedButton(
            color: Colors.white,
            shape: popUpButtonStyle,
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'No',
              style: kMainTextStyle.copyWith(
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    )) ??
        false;
  }

}
