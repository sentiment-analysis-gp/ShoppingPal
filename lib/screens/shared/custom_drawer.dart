import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.66,
      child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: size.height * 0.15,
                  child: DrawerHeader(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: ExactAssetImage("assets/images/logo.png"),
                          radius: size.width*0.07,
                        ),
                        SizedBox(width: 10.0,),
                        Text(
                          'Ibrahim Salama',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    //ToDo: Update the state of the app.
                  },
                ),
              ])),
    );
  }
}
