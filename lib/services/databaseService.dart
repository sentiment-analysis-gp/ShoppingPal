import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_pal/models/product.dart';

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

  Stream getSearchHistoryStream() {
    return loggedInUserDocument.snapshots(includeMetadataChanges: true);
  }
}
