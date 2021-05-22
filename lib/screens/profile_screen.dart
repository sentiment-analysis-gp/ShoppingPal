import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shopping_pal/models/user.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_pal/screens/shared/custom_drawer.dart';
import 'package:shopping_pal/screens/shared/search_appbar.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/services/databaseService.dart';

class ProfileScreen extends StatefulWidget {
  User user;

  ProfileScreen({this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

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
                  child: widget.user.imageURL.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(size.width * 0.5),
                          child: Image.network(
                            widget.user.imageURL,
                            width: size.width * 0.6,
                            height: size.width * 0.6,
                            fit: BoxFit.fitHeight,
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
                    widget.user.phoneNumber,
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
                    widget.user.email,
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

  _imgFromCamera() async {
    PickedFile image = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    _cropImage(image);
  }

  _imgFromGallery() async {
    PickedFile image = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    _cropImage(image);

    /*setState(() {
      _image = File(image.path);
    });*/
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
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: kPrimaryColor,
                    ),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<Null> _cropImage(PickedFile pickedImage) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: kPrimaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Image',
        ));
    if (croppedFile != null) {
      DatabaseService service = DatabaseService();
      var o = await service.uploadImageToFirebase(context, croppedFile);
      widget.user = await service.getUserDetails();
      setState(() {
        widget.user.imageURL;
      });
    }
  }
}
