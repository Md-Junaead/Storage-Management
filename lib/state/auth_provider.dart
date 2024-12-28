import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  // Sign Up Method
  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
      return null; // No error
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign In Method
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
      return null; // No error
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign Out Method
  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  // Check if the user is already signed in
  Future<void> checkUserStatus() async {
    _user = _auth.currentUser;
    notifyListeners();
  }

  // Reset Password Method
  Future<String?> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null; // No error
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
