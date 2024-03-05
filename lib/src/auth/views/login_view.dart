import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_button.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_text_form.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_wave_shape.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String path = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                Positioned(
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        CustomTextForm(
                          hintText: 'Email',
                          obscureText: false,
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        SizedBox(height: 20),
                        CustomTextForm(
                          hintText: 'Password',
                          obscureText: true,
                          prefixIcon: Icon(Icons.password_outlined),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.go('/forgot-password');
                              },
                              child: Text(
                                'Recover',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2 - 30,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        customButton(text: 'Log In', onTap: () {}),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.go('/signup');
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
