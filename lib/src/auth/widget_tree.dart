import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          if (snapshot.hasData) {
            return const HomeView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}
