import 'package:flutter/material.dart';
import 'package:shopping_pal/screens/welcome_screen.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      title: 'ShoppingPal',
      theme: kCustomThemeData,
      routes: kAppRoutes,
    );
  }
}
