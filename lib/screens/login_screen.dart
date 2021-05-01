import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/services/authenticationService.dart';

class LoginScreen extends StatelessWidget {
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: size.width * 0.2,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: size.width * 0.4,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/logo.png",
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: size.width * 0.8,
                  child: TextField(
                    style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: kPrimaryColor,
                      ),
                      hintText: "Email",
                      border: InputBorder.none,
                      hintStyle:
                          kMainTextStyle.copyWith(color: kSecondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: size.width * 0.8,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        hintText: "Password",
                        border: InputBorder.none,
                        hintStyle:
                            kMainTextStyle.copyWith(color: kSecondaryColor)),
                  ),
                ),
                Center(
                  child: Container(
                    width: size.width * 0.6,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: kPrimaryColor,
                      highlightColor: kSecondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        AuthenticationService().signIn(email, password);
                      },
                      child: Text(
                        "Login",
                        style: kMainTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
