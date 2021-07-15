//import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_pal/models/product.dart';
import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/screens/product_screen.dart';
import 'package:shopping_pal/services/databaseService.dart';

class ProductCard extends StatelessWidget {
  Product product;
  ParentScreen parentScreen;
  Widget actionsRow;
  final DatabaseService _dbService = DatabaseService();

  ProductCard({this.product, this.parentScreen});

  Future<Product> getProductFromSearchHistory() async {
    return await _dbService.getProductDetails(
        product.productName, ParentScreen.history);
  }

  Future<Product> getProductFromWishList() async {
    return await _dbService.getProductDetails(
        product.productName, ParentScreen.wishList);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (parentScreen == ParentScreen.history) {
      actionsRow = Row(
        children: [
          IconButton(
              icon: Icon(Icons.add_shopping_cart_outlined),
              onPressed: () async {
                await _dbService.addProductToWishList(product);
                /*Fluttertoast.showToast(
                    msg: "Added to wishlist",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
                    backgroundColor: Colors.grey[700],
                    textColor: Colors.white);*/
              }),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              _dbService.removeProductFromSearchHistory(product);
            },
          )
        ],
      );
    } else {
      actionsRow = IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          _dbService.removeProductFromWishList(product);
        },
      );
    }

    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.02),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: kSecondaryColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5.0,
          child: InkWell(
            splashColor: Colors.grey[300],
            onTap: () async {
              Product product = parentScreen == ParentScreen.history
                  ? await getProductFromSearchHistory()
                  : await getProductFromWishList();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductScreen(
                            product: product,
                          )));
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(size.width * 0.04, size.width * 0.02,
                  size.width * 0.02, size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.productName,
                          style: kSecondaryTextStyle.copyWith(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                      actionsRow
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(product.productPrice.toString() + r"$",
                      style: kSecondaryTextStyle.copyWith(
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                    children: [
                      TableRow(
                        children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: ExactAssetImage(
                                  "assets/images/amazon_logo.png"),
                              radius: size.width * 0.05,
                              backgroundColor: Colors.white,
                            ),
                          ],
                        ),
                        Text(
                          product.productAmazonRating.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Icon(setSentimentIcon(
                            double.parse(product.productAmazonRating))),
                      ]),
                      TableRow(children: [
                        SizedBox(
                          height: 0.0,
                        ),
                        SizedBox(
                          height: 0.0,
                        ),
                        SizedBox(
                          height: 0.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        )
                      ]),
                      TableRow(children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: ExactAssetImage(
                                  "assets/images/launcher_icon.png"),
                              radius: size.width * 0.05,
                              backgroundColor: Colors.white,
                            ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0, size.height*0.0, 0.0, 0.0),
                            child: Text(
                              product.productModelRating.toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0.0, size.height*0.0, 0.0, 0.0),
                            child: Icon(setSentimentIcon(product.productModelRating.toDouble())),
                          ),
                        ]
                      )
                    ],
                  )
                  /*Padding(
                    padding: EdgeInsets.fromLTRB(size.width * 0.01,
                        size.width * 0.0, size.width * 0.0, size.width * 0.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              ExactAssetImage("assets/images/amazon_logo.png"),
                          radius: size.width * 0.05,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          product.productAmazonRating.toString(),
                          style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                          ),
                        ),
                        /*SizedBox(
                          width: size.width * 0.39,
                        ),*/
                        Icon(setSentimentIcon(product.productAmazonRating)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(size.width * 0.01,
                        size.width * 0.0, size.width * 0.08, size.width * 0.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: ExactAssetImage(
                              "assets/images/launcher_icon.png"),
                          radius: size.width * 0.05,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          product.productModelRating.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /*SizedBox(
                          width: size.width * 0.39,
                        ),*/
                        Icon(setSentimentIcon(
                            product.productModelRating.toDouble())),
                      ],
                    ),
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleClick(String value) {}
}

IconData setSentimentIcon(double productRating) {
  return (productRating < 1)
      ? Icons.sentiment_dissatisfied_outlined
      : (productRating == 1)
          ? Icons.sentiment_neutral_outlined
          : Icons.sentiment_satisfied_outlined;
}
