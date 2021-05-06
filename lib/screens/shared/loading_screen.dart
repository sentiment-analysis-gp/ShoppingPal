import 'package:flutter/material.dart';
import 'package:shopping_pal/models/product.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:shopping_pal/services/databaseService.dart';
import 'dart:convert';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupProduct() async{
    DatabaseService db = DatabaseService();
    List<Map<String, dynamic>> result = await db.getProduct();
    Navigator.pushReplacementNamed(context, '/home', arguments: (result!=null)?result:{
      "productName" : "Not Found",
      "productPrice" : "",
      "productModelRating": "",
      "productAmazonRating": "",
      "productImageURL": "",
      "productURL": ""
    });
  }

  @override
  void initState(){
    super.initState();
    setupProduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitRotatingCircle(
                color: Colors.blue[700],
                size: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                child: Text(
                  'Loading',
                  style: TextStyle(
                    fontSize: 40.0,
                    letterSpacing: 2.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

}
