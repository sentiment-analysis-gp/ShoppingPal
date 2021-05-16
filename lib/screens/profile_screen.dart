import 'package:flutter/material.dart';
import 'package:shopping_pal/models/user.dart';
import 'package:shopping_pal/screens/shared/custom_drawer.dart';
import 'package:shopping_pal/screens/shared/search_appbar.dart';
import 'package:shopping_pal/constants.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  ProfileScreen({this.user});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: SearchAppBar(),
      drawer: CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(size.width * 0.0, size.width * 0.1,
            size.width * 0.0, size.width * 0.0),
        child: Align(
          alignment: AlignmentDirectional.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: kSecondaryColor,
                radius: size.width * 0.2 + 3.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person_outline,
                    color: kPrimaryColor,
                    size: size.width * 0.2,
                  ),
                  radius: size.width * 0.2,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                user.name,
                style: kSecondaryTextStyle.copyWith(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone_outlined,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    user.phoneNumber,
                    style: kSecondaryTextStyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email_outlined,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    user.email,
                    style: kSecondaryTextStyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Divider(
                color: kSecondaryColor,
                thickness: 3.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
