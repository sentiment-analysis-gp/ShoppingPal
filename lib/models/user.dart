import 'package:flutter/cupertino.dart';
import 'product.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  List<Product> wishList;
  List<Product> searchHistory;
  User(
      {@required this.uid,
      @required this.name,
      @required this.email,
      @required this.phoneNumber});
  User.fromData(Map<String, dynamic> data)
      : uid = data['id'],
        name = data['fullName'],
        email = data['email'],
        phoneNumber = data['phoneNumber'];
  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'fullName': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
