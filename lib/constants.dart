import 'package:flutter/material.dart';
import 'package:shopping_pal/screens/home_screen.dart';
import 'package:shopping_pal/screens/search_result_screen.dart';
import 'package:shopping_pal/screens/shared/loading_screen.dart';
import 'package:shopping_pal/screens/welcome_screen.dart';
import 'package:shopping_pal/screens/login_screen.dart';
import 'package:shopping_pal/screens/sign_up_screen.dart';

const kPrimaryColor = Color(0xFF623797);
const kSecondaryColor = Color(0xFFD0B3F8);
final kAppRoutes = {
  '/': (context) => WelcomeScreen(),
  '/search': (context) => SearchScreen(), //HomeScreen(),
  '/home': (context) => HomeScreen(),
  '/login': (context) => LoginScreen(),
  '/signup': (context) => SignUpScreen(),
  '/loading': (context) => LoadingScreen(),
};
final kMainTextStyle = TextStyle(
  fontFamily: "Bungee",
  fontSize: 24,
  color: Colors.white,
);
final kSecondaryTextStyle = TextStyle(
  fontFamily: "Lato",
  fontSize: 18,
  color: Colors.black,
);
final ThemeData kCustomThemeData = ThemeData(
  primaryColor: kPrimaryColor,
  accentColor: kSecondaryColor,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),
);