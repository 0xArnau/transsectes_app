import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/auth/bloc/auth_bloc.dart';
import 'package:transsectes_app/src/home/views/home_view.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_button.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';
import 'package:transsectes_app/src/utils/Widgets/pdf_viewer_widget.dart';
import 'package:transsectes_app/src/utils/colors.dart';
import 'package:transsectes_app/src/utils/custom_snackbar.dart';

class LegalView extends StatefulWidget {
  final String email;
  final String password;

  const LegalView({
    super.key,
    required this.email,
    required this.password,
  });

  static const path = '/legal';

  @override
  State<LegalView> createState() => _LegalViewState();
}

class _LegalViewState extends State<LegalView> {
  bool _avisLegal = false;
  bool _clausulaInformativa = false;
  bool _privacitat = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: customScaffold(
        context: context,
        title: S.current.legal_documents,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(S.current.legalInfo),
                    ),
                    _checkboxPdfTile(
                      context: context,
                      checkbox: _avisLegal,
                      onChanged: (value) {
                        if (mounted) {
                          setState(() {
                            _avisLegal = value;
                          });
                        }
                      },
                      text: 'Avís legal',
                      path: 'assets/docs/legal/avis-legal.pdf',
                    ),
                    _checkboxPdfTile(
                      context: context,
                      checkbox: _clausulaInformativa,
                      onChanged: (value) {
                        if (mounted) {
                          setState(() {
                            _clausulaInformativa = value;
                          });
                        }
                      },
                      text: 'Clausula informativa',
                      path: 'assets/docs/legal/clausula-informativa.pdf',
                    ),
                    _checkboxPdfTile(
                      context: context,
                      checkbox: _privacitat,
                      onChanged: (value) {
                        if (mounted) {
                          setState(() {
                            _privacitat = value;
                          });
                        }
                      },
                      text: 'Privacitat',
                      path: 'assets/docs/legal/privacitat.pdf',
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Logger().d('Singing up');
                      context.go(HomeView.path);
                    } else if (state is AuthFailure) {
                      CustomSnackbar.error(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    return customButton(
                      text: S.current.signup,
                      onTap: () {
                        if (_avisLegal == false ||
                            _clausulaInformativa == false ||
                            _privacitat == false) {
                          CustomSnackbar.error(
                            context,
                            S.current.empty_fields,
                          );
                        } else {
                          BlocProvider.of<AuthBloc>(context).add(
                            SignUp(
                              email: widget.email,
                              password: widget.password,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _checkboxPdfTile({
    required BuildContext context,
    required bool checkbox,
    required Function(bool) onChanged,
    required String text,
    required String path,
  }) {
    return ListTile(
      leading: Checkbox(
        activeColor: kColorTitle,
        value: checkbox,
        onChanged: (value) => onChanged(value ?? false),
      ),
      title: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewerWidget(title: text, asset: path),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: kColorTitle,
          surfaceTintColor: kColorTitle,
        ),
        child: Text(
          text,
          style: TextStyle(decoration: TextDecoration.underline),
        ),
      ),
      trailing: Icon(Icons.picture_as_pdf),
    );
  }
}
