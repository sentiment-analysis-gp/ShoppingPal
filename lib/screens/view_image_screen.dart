import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/models/user.dart';
import 'package:shopping_pal/services/choose_profile_image.dart';
import 'package:shopping_pal/services/databaseService.dart';

class ViewImage extends StatefulWidget {
  User user;

  ViewImage({this.user});

  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: (widget.user.imageURL?.isNotEmpty ?? false)?Image.network(widget.user.imageURL):Text("No image to show")
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(
                  Icons.photo_library,
                color: kPrimaryColor,
                ),
                onPressed: () async {
                  await SetProfileImage.chooseImageFromGallery();
                  User user = await _databaseService.getUserDetails();
                  setState(() {
                    if(user != null)
                      widget.user = user;
                  });
                }
              ),
            label: 'gallery',
          ),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(
                  Icons.photo_camera,
                  color: kPrimaryColor,
                ),
                onPressed: ()async {
                  await SetProfileImage.chooseImageFromCamera();
                  User user = await _databaseService.getUserDetails();
                  setState(() {
                    if(user != null)
                      widget.user = user;
                  });
                },
              ),
            label: 'camera',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(
                Icons.delete,
                color: kPrimaryColor,
              ),
              onPressed: ()async {
                DatabaseService service = DatabaseService();
                await service.deleteImageFromFirebase(widget.user.imageURL);
                widget.user = await service.getUserDetails();
                setState(() {
                  widget.user.imageURL;
                });
              },
            ),
            label: 'Remove',
          ),
        ],
      ),
    );
  }
}
