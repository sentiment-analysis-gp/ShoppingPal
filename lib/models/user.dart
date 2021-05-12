import 'package:flutter/cupertino.dart';
import 'product.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  List<Product> wishList;
  var searchHistory = {};

  User(
      {@required this.uid,
      @required this.name,
      @required this.email,
      @required this.phoneNumber,
      this.searchHistory});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['id'],
      name: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      searchHistory: json['searchHistory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'fullName': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
