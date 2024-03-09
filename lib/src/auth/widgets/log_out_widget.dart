import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:transsectes_app/src/auth/bloc/auth_bloc.dart';
import 'package:transsectes_app/src/auth/views/login_view.dart';

Widget logOutWidget() {
  return BlocProvider(
    create: (context) => AuthBloc(),
    child: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        Logger().d(state);
        if (state is AuthSuccess) {
          context.go(LoginView.path);
        } else if (state is AuthFailure) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Text('error'),
                );
              });
        }
      },
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(SignOut());
          },
          icon: Icon(Icons.logout_outlined),
          label: Text('Logut'),
        );
      },
    ),
  );
}
