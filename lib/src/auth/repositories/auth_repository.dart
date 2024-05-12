import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/utils/custom_snackbar.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  void userReload() => _firebaseAuth.currentUser!.reload();

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
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      Logger().d(isEmailVerified);
      if (!isEmailVerified()) {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();

        CustomSnackbar.info(context,
            'Pls verify your account. An email with instructions has been send');
      }
    } catch (e) {
      Logger().d(e.toString());
    }
  }

  bool isEmailVerified() {
    userReload;
    return _firebaseAuth.currentUser!.emailVerified;
  }

  /// Remove the user information (Collection 'Users') and the user account (Auth)
  Future<void> deleteUserAccountAndInformation(BuildContext context) async {
    Logger().d("deleteUserAccountAndInformation");
    try {
      await FirebaseAuth.instance.currentUser?.delete();
      Logger().d("Delete user");
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'requires-recent-login') {
        // Manejo específico para la excepción 'requires-recent-login'
        Logger().d('Requires recent login');
        CustomSnackbar.error(
            context, 'Please logout and login before deleting your account');
      } else {
        // Captura de otras excepciones
        Logger().d(e.toString());
        CustomSnackbar.error(
            context, 'An error occurred while trying to delete your account');
      }
    }
  }
}
