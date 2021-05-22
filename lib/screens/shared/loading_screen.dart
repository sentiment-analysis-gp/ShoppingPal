import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/models/user.dart';
import 'package:shopping_pal/screens/home_screen.dart';
import 'package:shopping_pal/screens/profile_screen.dart';
import 'package:shopping_pal/services/authenticationService.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shopping_pal/services/databaseService.dart';

class LoadingScreen extends StatefulWidget {
  final String routeName;
  final String email;
  final String password;
  final String name;
  final String phoneNumber;

  LoadingScreen(
      {@required this.routeName,
      @required this.email,
      @required this.password,
      this.phoneNumber,
      this.name});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  DatabaseService _dbService;

  Future<Widget> setupLoadingScreen() async {
    switch (widget.routeName) {
      case '/login':
        Future result =
        await AuthenticationService().signIn(widget.email, widget.password);
        _dbService = DatabaseService();
        return Future.value(HomeScreen());
        break;
      case '/signup':
        Future result = await AuthenticationService().signUpWithEmail(
            email: widget.email,
            password: widget.password,
            name: widget.name,
            phoneNumber: widget.phoneNumber);
        result =
            await AuthenticationService().signIn(widget.email, widget.password);
        return Future.value(HomeScreen());
        break;
      case '/profile':
        User user = await _dbService.getUserDetails();
        return Future.value(ProfileScreen(
          user: user,
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SplashScreen(
        navigateAfterFuture: setupLoadingScreen(),
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
