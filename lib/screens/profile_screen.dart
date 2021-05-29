import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shopping_pal/models/user.dart';
import 'package:shopping_pal/services/choose_profile_image.dart';
import 'package:shopping_pal/screens/shared/custom_drawer.dart';
import 'package:shopping_pal/screens/shared/search_appbar.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/screens/view_image_screen.dart';
import 'package:shopping_pal/services/databaseService.dart';

class ProfileScreen extends StatefulWidget {
  User user;

  ProfileScreen({this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Size size;
  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    if(widget.user==null)
      widget.user = ModalRoute.of(context).settings.arguments;

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

              ColumnSuper(
              innerDistance: -size.width * 0.05,
              children: [
                CircleAvatar(
                  backgroundColor: kSecondaryColor,
                  radius: size.width * 0.2 + 3.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: (widget.user.imageURL?.isNotEmpty ?? false)
                        ? ClipRRect(
                          borderRadius:
                                BorderRadius.circular(size.width * 0.5),
                          child: InkWell(splashColor: Colors.white,
                            radius: size.width * 0.5,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute (
                                builder: (BuildContext context) => ViewImage(user: widget.user,))
                              ).then((value) async{
                                widget.user = await _databaseService.getUserDetails();
                                setState(() {
                                  widget.user;
                                });
                              });
                            },
                            child: Image.network(
                                widget.user.imageURL,
                                width: size.width * 0.6,
                                height: size.width * 0.6,
                                fit: BoxFit.fitHeight,
                              ),
                          ),
                        )
                        : Icon(
                            Icons.person_outline,
                            color: kPrimaryColor,
                            size: size.width * 0.2,

                          ),
                    radius: size.width * 0.2,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _showPicker(context);
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: 20.0,
              ),
              Text(
                  widget.user.name,
                  style: kSecondaryTextStyle.copyWith(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.phone_outlined,
                  color: kPrimaryColor,
                ),
                title: Text(
                  widget.user.phoneNumber,
                  style: kSecondaryTextStyle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.email_outlined,
                  color: kPrimaryColor,
                ),
                title: Text(
                  widget.user.email,
                  style: kSecondaryTextStyle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
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



  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(
                        Icons.photo_library,
                        color: kPrimaryColor,
                      ),
                      title: new Text('Photo Library'),
                      onTap: () async {
                        Navigator.of(context).pop();
                        await SetProfileImage.chooseImageFromGallery();
                        User user = await _databaseService.getUserDetails();
                        setState(() {
                          if(user != null)
                            widget.user = user;
                        });
                      }),
                  ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: kPrimaryColor,
                    ),
                    title: new Text('Camera'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      await SetProfileImage.chooseImageFromCamera();
                      User user = await _databaseService.getUserDetails();
                      setState(() {
                        if(user != null)
                          widget.user = user;
                      });
                    },
                  ),
                  ListTile(
                    leading: new Icon(
                      Icons.delete,
                      color: kPrimaryColor,
                    ),
                    title: new Text('Remove Photo'),
                    onTap: () async {
                      DatabaseService service = DatabaseService();
                      await service.deleteImageFromFirebase(widget.user.imageURL);
                      widget.user = await service.getUserDetails();
                      setState(() {
                        widget.user.imageURL;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


}
