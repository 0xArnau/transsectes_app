import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/features/auth/presentation/providers/sign_up_view_model_provider.dart';
import 'package:transsectes_app/app/features/auth/presentation/viewmodels/sign_up_view_model.dart';
import 'package:transsectes_app/generated/l10n.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  late final SignUpViewModel signUpViewModel;

  final _emailController = TextEditingController();
  final _emailConfirmController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (mounted) {
      setState(() {
        signUpViewModel = ref.read(signUpViewModelProvider);
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailConfirmController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.signup),
      ),
    );
  }
}
