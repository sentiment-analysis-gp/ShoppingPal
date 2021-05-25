import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/screens/shared/loading_screen.dart';

class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() =>_SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String name;

  String error;

  String email;

  String password;

  String phoneNumber;

  String confirmPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Expanded(
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
                      style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      onChanged: (String entered) {
                        name = entered;
                      },
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
                      keyboardType: TextInputType.phone,
                      onChanged: (String entered) {
                        phoneNumber = entered;
                      },
                      style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 18,
                        color: Colors.black,
                      ),
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
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      onChanged: (String entered) {
                        email = entered;
                      },
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
                      onChanged: (String entered) {
                        password = entered;
                      },
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
                      onChanged: (String entered) {
                        confirmPassword = entered;
                      },
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
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: kPrimaryColor,
                        highlightColor: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if(validateInput())
                            {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoadingScreen(
                                    email: email,
                                    password: password,
                                    name: name,
                                    phoneNumber: phoneNumber,
                                    routeName: '/signup',
                                    previousWidget: this,
                                  ),
                                ),
                              );
                              print('$result');
                              /*if(mounted)
                            error = '$result';*/
                              if (mounted) {
                                setState(() {
                                  error = '$result';
                                });
                              }
                            }
                        },
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
      ),
    );
  }

  bool validateInput(){
    if(name?.isEmpty?? true) {
      error = "User name is required, please provide your name";
      setErrorState();
      return false;
    }
    if(phoneNumber?.isEmpty?? true) {
      error = "Phone number is required, please provide your phone number";
      setErrorState();
      return false;
    }
    if(email?.isEmpty?? true) {
      error = "Email is required, please provide your email";
      setErrorState();
      return false;
    }
    if(password?.isEmpty?? true) {
      error = "Password is required, please provide your password";
      setErrorState();
      return false;
    }
    if(confirmPassword?.isEmpty?? true) {
      error = "Please rewrite your password to confirm it";
      setErrorState();
      return false;
    }
    if(password != confirmPassword) {
      error = "The passwords did not match";
      setErrorState();
      return false;
    }
    return true;
  }

  void setErrorState(){
    setState(() {
      error;
    });
  }
}
