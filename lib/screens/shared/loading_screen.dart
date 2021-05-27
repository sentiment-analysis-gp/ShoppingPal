import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/models/user.dart';
import 'package:shopping_pal/screens/home_screen.dart';
import 'package:shopping_pal/screens/profile_screen.dart';
import 'package:shopping_pal/services/authenticationService.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shopping_pal/services/databaseService.dart';

import '../sign_up_screen.dart';

class LoadingScreen extends StatefulWidget {
  final String routeName;
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  final State<SignUpScreen> previousWidget;

  LoadingScreen(
      {@required this.routeName,
      @required this.email,
      @required this.password,
      this.phoneNumber,
      this.name,
        this.previousWidget,
      });

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  DatabaseService _dbService;

  Future<void> setupLoadingScreen() async {
    switch (widget.routeName) {
      case '/login':
        Future result =
        await AuthenticationService().signIn(widget.email, widget.password);
        _dbService = DatabaseService();
        Navigator.popUntil(context, ModalRoute.withName('/'));
        Navigator.pushNamed(context, '/home');
        break;
      case '/signup':
        var result = await AuthenticationService().signUpWithEmail(
            email: widget.email,
            password: widget.password,
            name: widget.name,
            phoneNumber: widget.phoneNumber);
        if(result == null || result == "null") {
          Navigator.popUntil(context, ModalRoute.withName('/'));
          Navigator.pushNamed(context, '/home');
        } else {
          Navigator.pop(context, result);
        }
        break;
      case '/profile':
        User user = await _dbService.getUserDetails();
        Navigator.pushNamed(context, '/profile', arguments: user);
        /*return Future.value(ProfileScreen(
          user: user,
        ));*/
        break;
    }
  }

  void initState() {
    super.initState();
    setupLoadingScreen();
  }

  /*Future<String> dummy() async{
    Future result =
    await AuthenticationService().signIn(widget.email, widget.password);
    _dbService = DatabaseService();
    return '/home';
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: SplashScreen(
          seconds: 20,
          //navigateAfterFuture: dummy(),
          backgroundColor: Colors.white,
          image: Image.asset('assets/images/loading_screen.gif'),
          photoSize: size.width * 0.4,
          title: Text(
            'ShoppingPal',
            style: kMainTextStyle.copyWith(color: kPrimaryColor),
          ),
          loaderColor: kPrimaryColor,
          loadingText: Text(
            widget.routeName == '/login' ? 'Logging In ...' : 'Signing Up',
            style: kMainTextStyle.copyWith(color: kPrimaryColor),
          ),
        ),
      );
  }
}
