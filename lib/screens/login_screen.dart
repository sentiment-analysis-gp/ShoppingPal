import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/screens/shared/loading_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  String error;

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
            SingleChildScrollView(
              physics: (MediaQuery.of(context).viewInsets.bottom == 0)
                  ? NeverScrollableScrollPhysics()
                  : null,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'banner',
                        child: Container(
                          child: Image.asset(
                            "assets/images/logo.png",
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: size.width * 0.8,
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
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
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        width: size.width * 0.8,
                        child: TextField(
                          textInputAction: TextInputAction.done,
                          onSubmitted: (value) {
                            signIn();
                          },
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
                              hintStyle: kMainTextStyle.copyWith(
                                  color: kSecondaryColor)),
                        ),
                      ),
                      (error?.isNotEmpty ?? false)
                          ? Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                              width: size.width * 0.8,
                              child: Text(
                                error,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 0,
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
                              signIn();
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateInput() {
    if (email?.isEmpty ?? true) {
      error = "Please enter your email";
      setState(() {
        error;
      });
      return false;
    }
    if (password?.isEmpty ?? true) {
      error = "Please enter your password";
      setState(() {
        error;
      });
      return false;
    }
    return true;
  }

  Future<void> signIn() async {
    FocusScope.of(context).unfocus();
    if (validateInput()) {
      String result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(
            email: email,
            password: password,
            routeName: '/login',
          ),
        ),
      );
      if (mounted) {
        setState(() {
          error = result;
        });
      }
    }
  }
}
