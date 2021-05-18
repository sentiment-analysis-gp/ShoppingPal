import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_pal/constants.dart';
import 'package:shopping_pal/models/product.dart';
import 'package:shopping_pal/models/user.dart' as model;

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _dbUsers =
      FirebaseFirestore.instance.collection('users');
  var productRef;
  DocumentReference loggedInUserDocument;

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
}
