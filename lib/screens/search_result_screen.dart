import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_pal/screens/shared/custom_drawer.dart';
import 'package:shopping_pal/screens/shared/search_appbar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: SearchAppBar(),
      drawer: CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: ExactAssetImage("assets/images/logo.png"),
              radius: size.width*0.2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(size.width*0.3, 0, 0, size.width*0.3),
                child: Icon(
                    Icons.add_circle_outlined,
                  size: size.width*0.09,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            SizedBox(height:15.0),
            Text(
              "Product Name",
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            SizedBox(height:15.0),
            Text(
              "ShoppingPal Rating: 5/5",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(width:10.0),
            Text(
              "Amazon Rating: 5/5",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height:15.0),
            Card(
              child: Column(
                //mainAxisAlignment: ,
                children: [
                  Text(
                    "Postive Review Sample:",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "This Product is Awesome",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
