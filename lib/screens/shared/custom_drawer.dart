import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/services/authenticationService.dart';

class CustomDrawer extends StatelessWidget {
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
                      child: Icon(
                        Icons.person_outline,
                        color: kPrimaryColor,
                        size: size.width * 0.07,
                      ),
                      radius: size.width * 0.07,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'A. Montasser',
                      style: kMainTextStyle.copyWith(
                        fontSize: 20,
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
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
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
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
            ),
          ]),
        ),
      ),
    );
  }
}
