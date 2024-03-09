import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transsectes_app/src/auth/views/login_view.dart';
import 'package:transsectes_app/src/home/views/home_view.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_wave_shape.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const String path = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late String goto;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (FirebaseAuth.instance.currentUser != null) {
        goto = HomeView.path;
      } else {
        goto = LoginView.path;
      }
    }).then((value) => context.go(goto));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4 + 10,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.height / 4,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kColorButtons,
                      ),
                    ),
                  ),
                  const SafeArea(
                    child: Text(
                      'Transsectes APP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: kColorTitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomWaveShape(context),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SafeArea(
                    child: Image.asset(
                      'assets/imgs/background/imatge_tortuga.png',
                      fit: BoxFit.fitWidth,
                      height: MediaQuery.of(context).size.width / 1.12,
                    ),
                  ),
                ),
                SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      // 'assets/imgs/logo/GEPEC_EdC_OFICIAL.png',
                      'assets/imgs/logo/GEPEC_EdC_OFICIAL_blanc.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
