import 'package:flutter/material.dart';
import 'product.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;

  dynamic wishList;
  dynamic searchHistory;
  final String imageURL;

  User(
      {@required this.uid,
      @required this.name,
      @required this.email,
      @required this.phoneNumber,
      this.searchHistory,
      this.imageURL,
      this.wishList});


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['id'],
      name: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      searchHistory: json['searchHistory'],
      wishList: json['wishList'],
      imageURL: json['imageURL']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'fullName': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'wishList': wishList,
      'searchHistory': searchHistory,
      'imageURL': imageURL,
    };
  }

  @override
  String toString() {
    return 'id: $uid\nfullName: $name\nemail: $email\nphoneNumber: $phoneNumber\nwishList: $wishList\nsearchHistory: $searchHistory';
  }
}
