import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_pal/models/user.dart' as model;

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _dbUsers =
      FirebaseFirestore.instance.collection('users');

  Future signOut() {
    return _auth.signOut();
  }

  Future signUpWithEmail(
      {String name, String email, String phoneNumber, String password}) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      model.User user = model.User(
          uid: authResult.user.uid,
          name: name,
          email: email,
          phoneNumber: phoneNumber);
      createUser(user);
    } catch (e) {
      return e.message;
    }
  }

  Future createUser(model.User user) async {
    try {
      await _dbUsers.doc(user.uid).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  signIn(String email, String password) async {
    try {
      dynamic data;
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var userData = await _dbUsers
          .doc(result.user.uid)
          .get()
          .then((value) => data = value.data());
      model.User user = model.User.fromData(data);
      print(user.uid);
      return;
    } catch (e) {
      print(e);
    }
  }
}
