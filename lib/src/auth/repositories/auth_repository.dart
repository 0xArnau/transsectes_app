import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/web.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }

  Future<void> singOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }

  Future<bool> isSignedIn() async {
    try {
      return (await _firebaseAuth.currentUser) != null;
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }

  Future<String?> getUserEmail() async {
    try {
      return (await _firebaseAuth.currentUser)?.email;
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }
}
