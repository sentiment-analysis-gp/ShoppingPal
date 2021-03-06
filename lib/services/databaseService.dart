import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/models/product.dart';
import 'package:shopping_pal/models/product_info.dart';
import 'package:shopping_pal/models/product_reviews.dart';
import 'package:shopping_pal/models/user.dart' as model;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _dbUsers =
      FirebaseFirestore.instance.collection('users');
  var productRef;
  DocumentReference loggedInUserDocument;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DatabaseService() {
    productRef = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser.uid)
        .withConverter(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
          toFirestore: (product, _) => product.toJson(),
        );
    loggedInUserDocument = _dbUsers.doc(_auth.currentUser.uid);
  }

  void addProductToSearchHistory(Product product) async {
    loggedInUserDocument
        .update({'searchHistory.${product.productName}': product.toJson()});
  }

  void removeProductFromSearchHistory(Product product) async {
    loggedInUserDocument
        .update({'searchHistory.${product.productName}': FieldValue.delete()});
  }

  void removeProductFromWishList(Product product) async {
    loggedInUserDocument
        .update({'wishList.${product.productName}': FieldValue.delete()});
  }

  void addProductToWishList(Product product) async {
    loggedInUserDocument
        .update({'wishList.${product.productName}': product.toJson()});
  }

  Future<void> addImageURL(String imageURL) async {
    return await loggedInUserDocument.update({'imageURL': imageURL});
  }

  Future<void> removeImageURL() async {
    return await loggedInUserDocument.update({'imageURL': ""});
  }

  Future<model.User> getUserDetails() async {
    DocumentSnapshot documentSnapshot = await loggedInUserDocument.get();
    model.User user = model.User.fromJson(documentSnapshot.data());
    return user;
  }

  Future<Product> getProductDetails(
      String productName, ParentScreen productListName) async {
    model.User user = await getUserDetails();
    Product product = productListName == ParentScreen.wishList
        ? Product.fromJson(user.wishList[productName])
        : Product.fromJson(user.searchHistory[productName]);
    return product;
  }

  Stream getSearchHistoryStream() {
    return loggedInUserDocument.snapshots(includeMetadataChanges: true);
  }

  Future<void> uploadImageToFirebase(
      /*BuildContext context,*/ File _imageFile) async {
    String fileName = basename(_imageFile.path);
    TaskSnapshot uploadTask =
        await storage.ref('profilePictures/$fileName').putFile(_imageFile);
    addImageURL(await uploadTask.ref.getDownloadURL());
    return;
  }

  Future<void> deleteImageFromFirebase(
      /*BuildContext context,*/
      String imageUrl) async {
    await storage.refFromURL(imageUrl).delete();
    removeImageURL();
    return;
  }

  static Product productBuilder(
      ProductInfo productInfo, ProductReviews productReviews) {
    return Product(
        productName: productInfo.productName,
        productPrice: productInfo.productPrice,
        productAmazonRating: productInfo.productAmazonRating,
        productImageURL: productInfo.productImageURL,
        productModelRating: productReviews.productModelRating,
        numberOfReviews: productReviews.numberOfReviews,
        negSample: productReviews.negSample,
        neutSample: productReviews.neutSample,
        numberOfNegReviews: productReviews.numberOfNegReviews,
        numberOfNeutReviews: productReviews.numberOfNeutReviews,
        numberOfPosReviews: productReviews.numberOfPosReviews,
        posSample: productReviews.posSample,
        productURL: productInfo.productURL);
  }
}
