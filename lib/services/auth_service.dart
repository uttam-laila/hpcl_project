import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  // Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    final auth.UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user?.uid;
  }

  @override
  Future<String> currentUser() async {
    final auth.User user = _firebaseAuth.currentUser;
    return user?.uid;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
