import 'package:flutter/material.dart';
import 'package:shopping_pal/screens/shared/custom_drawer.dart';
import 'package:shopping_pal/screens/shared/list_products.dart';
import 'package:shopping_pal/screens/shared/search_appbar.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/models/product.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
      }
    ];
    if (data != null) {
      data.forEach((element) {
        wishList.add(Product.fromData(element));
      });
    }

    return Scaffold(
      appBar: SearchAppBar(),
      drawer: CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(size.width * 0.0, size.width * 0.1,
            size.width * 0.0, size.width * 0.0),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Align(
            alignment: AlignmentDirectional.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: kSecondaryColor,
                  radius: size.width * 0.2 + 3.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_outline,
                      color: kPrimaryColor,
                      size: size.width * 0.2,
                    ),
                    radius: size.width * 0.2,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Ahmed Montasser",
                  style: kSecondaryTextStyle.copyWith(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      "01014403361",
                      style: kSecondaryTextStyle.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      "Ahmad.Montasser@yahoo.com",
                      style: kSecondaryTextStyle.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Divider(
                  color: kSecondaryColor,
                  thickness: 3.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Wishlist",
                  style: kSecondaryTextStyle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ProductList(
                  parentScreen: ParentScreen.wishList,
                  productList: wishList,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
