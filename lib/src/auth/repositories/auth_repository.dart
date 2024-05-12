import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

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
      return (_firebaseAuth.currentUser) != null;
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }

  Future<String?> getUserEmail() async {
    try {
      return (_firebaseAuth.currentUser)?.email;
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      Logger().e(e.toString());
      rethrow;
    }
  }

  /// Sends an email verification link to the user's email address
  Future<void> sendEmailVerification() async {
    try {
      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      }
    } catch (e) {
      Logger().d(e.toString());
    }
  }
}
