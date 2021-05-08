import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_pal/constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  RoundedRectangleBorder popUpButtonStyle = RoundedRectangleBorder(
    side: BorderSide(
      width: 3,
      color: kSecondaryColor,
    ),
    borderRadius: BorderRadius.circular(5),
  );

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                color: kSecondaryColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            titleTextStyle: kMainTextStyle.copyWith(
              color: kPrimaryColor,
            ),
            title: Column(
              children: [
                Text('Are you sure?'),
                Divider(
                  thickness: 3,
                  color: kSecondaryColor,
                ),
              ],
            ),
            content: Text(
              'Do you want to exit ?',
              textAlign: TextAlign.center,
              style: kMainTextStyle.copyWith(color: kPrimaryColor),
            ),
            actions: <Widget>[
              RaisedButton(
                color: Colors.white,
                shape: popUpButtonStyle,
                onPressed: () => SystemNavigator.pop(),
                child: Text(
                  'Yes',
                  style: kMainTextStyle.copyWith(
                      color: kSecondaryColor, fontSize: 16),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                shape: popUpButtonStyle,
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: kMainTextStyle.copyWith(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: size.width * 0.3,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_bottom.png",
                  width: size.width * 0.2,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/logo.png",
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20),
                    ),
                    Center(
                      child: Container(
                        width: size.width * 0.6,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          color: kPrimaryColor,
                          highlightColor: kSecondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            "Login",
                            style: kMainTextStyle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Container(
                        width: size.width * 0.6,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          color: kPrimaryColor,
                          highlightColor: kSecondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text("Sign Up", style: kMainTextStyle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
