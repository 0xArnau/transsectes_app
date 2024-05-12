import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/auth/repositories/auth_repository.dart';
import 'package:transsectes_app/src/home/views/home_view.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class VerifyView extends StatefulWidget {
  const VerifyView({super.key});

  static const path = "verify";

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    setState(() {
      isEmailVerified = AuthRepository().isEmailVerified();
    });

    _checkEmailVerified();
    if (!isEmailVerified) {
      timer = Timer.periodic(
        const Duration(milliseconds: 2000),
        (_) => _checkEmailVerified(),
      );
    }

    if (!isEmailVerified) AuthRepository().sendEmailVerification(context);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future _checkEmailVerified() async {
    AuthRepository().userReload();
    if (mounted) {
      setState(() {
        isEmailVerified = AuthRepository().isEmailVerified();
      });
    }

    Logger().d("isEmailVerified: $isEmailVerified");

    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const HomeView()
        : customScaffold(
            context: context,
            title: "Verify email",
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: kColorTitle,
                    ),
                    onPressed: () {
                      AuthRepository().sendEmailVerification(context);
                    },
                    child: const Text('Send email'),
                  ),
                  // TextButton(
                  //   style: TextButton.styleFrom(
                  //     foregroundColor: kColorTitle,
                  //   ),
                  //   onPressed: () {
                  //     AuthRepository().userReload();
                  //     setState(() {
                  //       isEmailVerified = AuthRepository().isEmailVerified();
                  //     });

                  //     if (!isEmailVerified) {
                  //       CustomSnackbar.error(context, 'Email is not verified');
                  //     }
                  //   },
                  //   child: const Text('Login'),
                  // ),
                ],
              ),
            ),
          );
  }
}
