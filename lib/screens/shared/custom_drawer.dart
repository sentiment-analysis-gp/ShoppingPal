import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/models/user.dart';
import 'package:shopping_pal/services/authenticationService.dart';
import 'package:shopping_pal/services/databaseService.dart';
import 'package:shopping_pal/services/navigatorStateExtension.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final DatabaseService _databaseService = DatabaseService();
  Size size;

  User user;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeUser();
  }

  void initializeUser() async {
    setState(() {
      isLoading = true;
    });
    user = await _databaseService.getUserDetails();
    setState(() {
      isLoading = false;
    });
  }

  final TextStyle textStyle = TextStyle(
    fontFamily: "Lato",
    fontSize: 18,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.66,
      child: Theme(
        data: Theme.of(context).copyWith(),
        child: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            Container(
              height: size.height * 0.2,
              child: DrawerHeader(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: selectCircleAvatarChild(),
                      radius: size.width * 0.07,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        user?.name ?? '',
                        style: kMainTextStyle.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_outlined, color: kPrimaryColor),
              title: Text(
                'Home',
                style: textStyle,
              ),
              onTap: () {
                if (!Navigator.of(context).isCurrent('/home')) {
                  Navigator.pop(context);
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                }
                //Navigator.of(context).pushNamedIfNotCurrent('/home');
              },
              tileColor: (Navigator.of(context).isCurrent('/home'))
                  ? Colors.grey[300]
                  : Colors.white,
            ),
            ListTile(
              leading: Icon(Icons.person_outline, color: kPrimaryColor),
              title: Text(
                'Profile',
                style: textStyle,
              ),
              onTap: () async {
                if (!Navigator.of(context).isCurrent('/profile')) {
                  user = await _databaseService.getUserDetails();
                  if (!Navigator.of(context).isCurrent('/home')) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    if (Navigator.of(context).isCurrent('/home')) {
                      Navigator.pushNamed(context, '/wishlist');
                      Navigator.pushNamed(context, '/profile', arguments: user);
                    }
                  } else {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile', arguments: user);
                  }
                }
              },
              tileColor: (Navigator.of(context).isCurrent('/profile'))
                  ? Colors.grey[300]
                  : Colors.white,
            ),
            ListTile(
              leading: Icon(Icons.star_outline, color: kPrimaryColor),
              title: Text(
                'Wishlist',
                style: textStyle,
              ),
              onTap: () {
                if (!Navigator.of(context).isCurrent('/wishlist')) {
                  if (!Navigator.of(context).isCurrent('/home')) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    if (Navigator.of(context).isCurrent('/home')) {
                      Navigator.pushNamed(context, '/profile', arguments: user);
                      Navigator.pushNamed(context, '/wishlist');
                    }
                  } else {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/wishlist', arguments: user);
                  }
                }
              },
              tileColor: (Navigator.of(context).isCurrent('/wishlist'))
                  ? Colors.grey[300]
                  : Colors.white,
            ),
            ListTile(
              leading: Icon(Icons.logout, color: kPrimaryColor),
              title: Text(
                'Logout',
                style: textStyle,
              ),
              onTap: () async {
                var result = await AuthenticationService().signOut();
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
          ]),
        ),
      ),
    );
  }

  String currentRoute() {
    return ModalRoute.of(context)?.settings?.name;
  }

  Widget selectCircleAvatarChild() {
    return (isLoading)
        ? SpinKitFadingCircle(
            color: kPrimaryColor,
            size: size.height * 0.07,
          )
        : (user?.imageURL?.isNotEmpty ?? false)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(size.width * 0.5),
                child: Image.network(
                  user.imageURL,
                  width: size.width * 0.14,
                  height: size.width * 0.14,
                  fit: BoxFit.fitHeight,
                ),
              )
            : Icon(
                Icons.person_outline,
                color: kPrimaryColor,
                size: size.width * 0.07,
              );
  }
}
