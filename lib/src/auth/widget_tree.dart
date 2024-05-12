import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/auth/repositories/auth_repository.dart';
import 'package:transsectes_app/src/auth/views/login_view.dart';
import 'package:transsectes_app/src/home/views/home_view.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  static const path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          Logger().d(snapshot);
          if (snapshot.hasData) {
            if (!snapshot.data!.emailVerified) {
              AuthRepository().sendEmailVerification();
              return const LoginView();
            } else {
              return const HomeView();
            }
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}
