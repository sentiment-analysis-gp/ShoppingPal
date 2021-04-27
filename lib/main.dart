import 'package:flutter/material.dart';
import 'package:shopping_pal/screens/welcome_screen.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShoppingPal',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      home: WelcomeScreen(),
    );
  }
}
