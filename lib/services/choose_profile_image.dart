import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_pal/models/user.dart';

import '../constants.dart';
import 'databaseService.dart';

class  SetProfileImage{

  static Future<User> chooseImageFromCamera() async {
    PickedFile image = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    return _cropImage(image);
  }

  static Future<User> chooseImageFromGallery() async {
    PickedFile image = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    return _cropImage(image);
  }

  static Future<User> _cropImage(PickedFile pickedImage) async {
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
      var o = await service.uploadImageToFirebase(croppedFile);
      return await service.getUserDetails();
    } else{
      return null;
    }
  }
}