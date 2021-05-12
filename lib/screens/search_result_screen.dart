import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_pal/screens/shared/custom_drawer.dart';
import 'package:shopping_pal/screens/shared/search_appbar.dart';
import 'package:shopping_pal/constants.dart';
import 'package:http/http.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({Key key}) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double pictureSize = size.width * 0.3;
    return Scaffold(
      appBar: SearchAppBar(),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/product_image_place_holder.png',
                    image: '',
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  fillColor: kPrimaryColor,
                  child: Icon(
                    Icons.add_outlined,
                    color: Colors.white,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
