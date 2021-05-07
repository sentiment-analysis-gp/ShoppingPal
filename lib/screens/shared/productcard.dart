import 'package:shopping_pal/models/product.dart';
import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';

class ProductCard extends StatelessWidget {
  Product product;
  ParentScreen parentScreen;
  Widget actionsRow;

  ProductCard({this.product, this.parentScreen});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if(parentScreen==ParentScreen.history){
      actionsRow = Row(
        children: [
          IconButton(
              icon: Icon(Icons.add_shopping_cart_outlined),
              onPressed: (){}
              ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){},
          )
        ],
      );
    } else {
      actionsRow = IconButton(
        icon: Icon(Icons.delete),
        onPressed: (){},
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
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.fromLTRB(size.width * 0.04, size.width * 0.02,
                  size.width * 0.02, size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.productName,
                        style: kSecondaryTextStyle.copyWith(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      actionsRow
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(product.productPrice,
                      style: kSecondaryTextStyle.copyWith(
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(size.width * 0.01,
                        size.width * 0.0, size.width * 0.0, size.width * 0.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: ExactAssetImage("assets/images/amazon_logo.png"),
                          radius: size.width * 0.05,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(width: size.width*0.05,),
                        Text(
                          product.productAmazonRating,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: size.width*0.39,),
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
                          backgroundImage: ExactAssetImage("assets/images/launcher_icon.png"),
                          radius: size.width * 0.05,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(width: size.width*0.05,),
                        Text(
                          product.productModelRating,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: size.width*0.39,),
                        Icon(setSentimentIcon(product.productAmazonRating)),
                      ],
                    ),
                  )
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

IconData setSentimentIcon(String produtcRating){
  return (int.parse(produtcRating.substring(0, produtcRating.indexOf("/"))) < 3) ?
  Icons.sentiment_dissatisfied_outlined
      : ((int.parse(produtcRating.substring(0, 1)) == 3) ?
  Icons.sentiment_neutral_outlined
      : Icons.sentiment_satisfied_outlined);
}
