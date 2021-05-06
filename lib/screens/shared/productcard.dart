import 'package:shopping_pal/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget{
  Product product;

  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.05 , vertical: size.height*0.02),
        child: Card(
          child: InkWell(
            splashColor: Colors.grey[300],
            onTap: (){},
            child: Padding(
              padding: EdgeInsets.fromLTRB(size.width*0.02,size.width*0.02,size.width*0.02,size.width*0.05),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          product.productName,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: handleClick,
                        itemBuilder: (BuildContext context) {
                          return {'Remove', 'Add To Wishlist'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                  SizedBox( height:4.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(size.width*0.01, size.width*0.0, size.width*0.15, size.width*0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            product.productPrice,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            product.productAmazonRating,
                          style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        )
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
  void handleClick(String value) {
  }
}