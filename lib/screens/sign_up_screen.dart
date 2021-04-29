import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';

class SignUpScreen extends StatelessWidget {
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
                "assets/images/sign_up_top.png",
                width: size.width * 0.2,
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
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.emoji_emotions_outlined,
                        color: kPrimaryColor,
                      ),
                      hintText: "Name",
                      border: InputBorder.none,
                      hintStyle: kMainTextStyle.copyWith(
                        color: kSecondaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
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
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone_outlined,
                        color: kPrimaryColor,
                      ),
                      hintText: "Phone Number",
                      border: InputBorder.none,
                      hintStyle: kMainTextStyle.copyWith(
                        color: kSecondaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
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
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email_outlined,
                        color: kPrimaryColor,
                      ),
                      hintText: "Email",
                      border: InputBorder.none,
                      hintStyle: kMainTextStyle.copyWith(
                        color: kSecondaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: size.width * 0.8,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock_outline,
                        color: kPrimaryColor,
                      ),
                      hintText: "Password",
                      border: InputBorder.none,
                      hintStyle: kMainTextStyle.copyWith(
                        color: kSecondaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  width: size.width * 0.8,
                  child: TextField(
                    obscureText: true,
                    style: kSecondaryTextStyle,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock_outline,
                        color: kPrimaryColor,
                      ),
                      hintText: "Confirm Password",
                      border: InputBorder.none,
                      hintStyle: kMainTextStyle.copyWith(
                        color: kSecondaryColor,
                        fontSize: 18,
                      ),
                    ),
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
                      onPressed: () {},
                      child: Text(
                        "Submit",
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
