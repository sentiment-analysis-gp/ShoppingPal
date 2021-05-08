import 'package:flutter/material.dart';
import 'package:shopping_pal/screens/home_screen.dart';
import 'package:shopping_pal/services/authenticationService.dart';
import 'package:splashscreen/splashscreen.dart';

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
  Future<Widget> setupLoadingScreen() async {
    switch (widget.routeName) {
      case '/login':
        Future result =
            await AuthenticationService().signIn(widget.email, widget.password);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SplashScreen(
        navigateAfterFuture: setupLoadingScreen(),
        backgroundColor: Colors.white,
        image: Image.asset('assets/images/loading_screen1.gif'),
        photoSize: 200,
      ),
    );
  }
}
