import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/auth/bloc/auth_bloc.dart';
import 'package:transsectes_app/src/auth/views/sign_up_view.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_button.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_text_form.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_wave_shape.dart';
import 'package:transsectes_app/src/utils/colors.dart';
import 'package:transsectes_app/src/utils/custom_snackbar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String path = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
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
                            controller: _emailController,
                            hintText: S.current.email,
                            obscureText: false,
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          const SizedBox(height: 20),
                          CustomTextForm(
                            controller: _passwordController,
                            hintText: S.current.password,
                            obscureText: true,
                            prefixIcon: const Icon(Icons.password_outlined),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                context.push('/forgot-password');
                              },
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(17, 3, 17, 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.grey.withOpacity(.2),
                                      Colors.grey.withOpacity(.2),
                                      Colors.grey.withOpacity(.2),
                                      Colors.grey.withOpacity(.2),
                                    ],
                                  ),
                                ),
                                child: Text(
                                  S.current.forgot_password,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.black,
                                  ),
                                ),
                              ),
                            ),
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
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthSuccess) {
                                // Not needed signInWithEmailAndPassword also signs the user in into the app and updates
                                // any [authStateChanges], [idTokenChanges] or [userChanges] stream listeners.
                                // context.go(HomeView.path);
                              } else if (state is AuthFailure) {
                                CustomSnackbar.error(context, state.message);
                              }
                            },
                            builder: (context, state) {
                              return customButton(
                                text: S.current.login,
                                onTap: () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    SignIn(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              context.push(SignUpView.path);
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(17, 3, 17, 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.black.withOpacity(.5),
                                    Colors.black.withOpacity(.5),
                                    Colors.black.withOpacity(.5),
                                    Colors.black.withOpacity(.5),
                                  ],
                                ),
                              ),
                              child: Text(
                                '${S.current.no_account} ${S.current.signup}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
