import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/auth/bloc/auth_bloc.dart';
import 'package:transsectes_app/src/auth/views/login_view.dart';
import 'package:transsectes_app/src/utils/Widgets/android_ios/alert_dialog_widget.dart';
import 'package:transsectes_app/src/utils/Widgets/android_ios/button_widget.dart';
import 'package:transsectes_app/src/utils/Widgets/android_ios/icon_widget.dart';

Widget logOutWidget(BuildContext context) {
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
        return ButtonWidget(
          text: S.current.signOut,
          icon: const IconWidget(
            android: Icons.logout,
            ios: CupertinoIcons.arrow_right_to_line,
          ) ,
          action: () => AlertDialogWidget.showAlertDialog(
            context: context,
            title: 'Want to logout?',
            primaryText: 'Sign Out',
            primaryFunction: () =>
                BlocProvider.of<AuthBloc>(context).add(SignOut()),
            secondaryText: 'Cancel',
            secondaryFunction: () {},
          ),
        );
      },
    ),
  );
}
