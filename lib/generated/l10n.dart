// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm email`
  String get confirm_email {
    return Intl.message(
      'Confirm email',
      name: 'confirm_email',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `The emails are different`
  String get emails_are_different {
    return Intl.message(
      'The emails are different',
      name: 'emails_are_different',
      desc: '',
      args: [],
    );
  }

  /// `There are empty fields`
  String get empty_fields {
    return Intl.message(
      'There are empty fields',
      name: 'empty_fields',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `How to do a transect`
  String get how2transect {
    return Intl.message(
      'How to do a transect',
      name: 'how2transect',
      desc: '',
      args: [],
    );
  }

  /// `There are incorrect fields`
  String get incorrect_fields {
    return Intl.message(
      'There are incorrect fields',
      name: 'incorrect_fields',
      desc: '',
      args: [],
    );
  }

  /// `Instructions sent by email`
  String get instructions_sent {
    return Intl.message(
      'Instructions sent by email',
      name: 'instructions_sent',
      desc: '',
      args: [],
    );
  }

  /// `invalid email`
  String get invalid_email {
    return Intl.message(
      'invalid email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please read the following legal documents and check the box to indicate that you agree and can register.`
  String get legalInfo {
    return Intl.message(
      'Please read the following legal documents and check the box to indicate that you agree and can register.',
      name: 'legalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Legal documents`
  String get legal_documents {
    return Intl.message(
      'Legal documents',
      name: 'legal_documents',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get no_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'no_account',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Start a transect`
  String get start_transect {
    return Intl.message(
      'Start a transect',
      name: 'start_transect',
      desc: '',
      args: [],
    );
  }

  /// `Transect records`
  String get transect_records {
    return Intl.message(
      'Transect records',
      name: 'transect_records',
      desc: '',
      args: [],
    );
  }

  /// `user disabled`
  String get user_disabled {
    return Intl.message(
      'user disabled',
      name: 'user_disabled',
      desc: '',
      args: [],
    );
  }

  /// `user not found`
  String get user_not_found {
    return Intl.message(
      'user not found',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `wrong password`
  String get wrong_password {
    return Intl.message(
      'wrong password',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get yes_account {
    return Intl.message(
      'Already have an account?',
      name: 'yes_account',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
