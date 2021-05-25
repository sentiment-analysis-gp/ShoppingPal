import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/models/user.dart';
import 'package:shopping_pal/screens/profile_screen.dart';
import 'package:shopping_pal/services/authenticationService.dart';
import 'package:shopping_pal/services/databaseService.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final DatabaseService _databaseService = DatabaseService();

  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeUser();
  }

  void initializeUser() async {
    user = await _databaseService.getUserDetails();
    setState(() {});
  }

  final TextStyle textStyle = TextStyle(
    fontFamily: "Lato",
    fontSize: 18,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      child: user?.imageURL != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.5),
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
                            ),
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
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.person_outline, color: kPrimaryColor),
              title: Text(
                'Profile',
                style: textStyle,
              ),
              onTap: () async {
                Navigator.pop(context);
                user = await _databaseService.getUserDetails();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      user: user,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.star_outline, color: kPrimaryColor),
              title: Text(
                'Wishlist',
                style: textStyle,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/wishlist');
              },
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
}
