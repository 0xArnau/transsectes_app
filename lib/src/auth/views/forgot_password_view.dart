import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/auth/bloc/auth_bloc.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_button.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_text_form.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_wave_shape.dart';
import 'package:transsectes_app/src/utils/colors.dart';
import 'package:transsectes_app/src/utils/custom_snackbar.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  static const String path = '/forgot-password';

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _emailController = TextEditingController();
  final _emailConfirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _emailConfirmController.dispose();
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
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              CustomTextForm(
                                controller: _emailController,
                                hintText: S.current.email,
                                obscureText: false,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              CustomTextForm(
                                controller: _emailConfirmController,
                                hintText: S.current.confirm_email,
                                obscureText: false,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                CustomSnackbar.info(
                                    context, S.current.instructions_sent);
                              } else if (state is AuthFailure) {
                                CustomSnackbar.error(context, state.message);
                              }
                            },
                            builder: (context, state) {
                              return customButton(
                                text: S.current.change_password,
                                onTap: () {
                                  if (_emailController.text.trim() ==
                                      _emailConfirmController.text.trim()) {
                                    BlocProvider.of<AuthBloc>(context).add(
                                      ResetPassword(
                                        email: _emailController.text.trim(),
                                      ),
                                    );
                                  } else {
                                    CustomSnackbar.error(context,
                                        S.current.emails_are_different);
                                  }
                                },
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              context.go('/login');
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(17, 3, 17, 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
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
                                S.current.yes_account + ' ' + S.current.login,
                                style: TextStyle(
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
