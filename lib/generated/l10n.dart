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

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `You cannot start a transect until you finish the current one.`
  String get cannot_start_transect {
    return Intl.message(
      'You cannot start a transect until you finish the current one.',
      name: 'cannot_start_transect',
      desc: '',
      args: [],
    );
  }

  /// `You can't stop a transect, there isn't one that's started`
  String get cannot_stop_transect {
    return Intl.message(
      'You can\'t stop a transect, there isn\'t one that\'s started',
      name: 'cannot_stop_transect',
      desc: '',
      args: [],
    );
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

  /// `If you observe a turtle on the sand, a track, hatchlings, an injured or dead turtle, or any other incident related to a sea turtle, call`
  String get contact_1 {
    return Intl.message(
      'If you observe a turtle on the sand, a track, hatchlings, an injured or dead turtle, or any other incident related to a sea turtle, call',
      name: 'contact_1',
      desc: '',
      args: [],
    );
  }

  /// `For any doubts or incidents related to transects or sea turtles, contact:`
  String get contact_2 {
    return Intl.message(
      'For any doubts or incidents related to transects or sea turtles, contact:',
      name: 'contact_2',
      desc: '',
      args: [],
    );
  }

  /// `Emergency phone numbers`
  String get contact_3 {
    return Intl.message(
      'Emergency phone numbers',
      name: 'contact_3',
      desc: '',
      args: [],
    );
  }

  /// `You can also visit our website`
  String get contact_4 {
    return Intl.message(
      'You can also visit our website',
      name: 'contact_4',
      desc: '',
      args: [],
    );
  }

  /// `Email address copied to clipboard`
  String get contact_clipboard_email {
    return Intl.message(
      'Email address copied to clipboard',
      name: 'contact_clipboard_email',
      desc: '',
      args: [],
    );
  }

  /// `Phone number copied to clipboard`
  String get contact_clipboard_phone {
    return Intl.message(
      'Phone number copied to clipboard',
      name: 'contact_clipboard_phone',
      desc: '',
      args: [],
    );
  }

  /// `The Website URL copied to clipboard`
  String get contact_clipboard_website {
    return Intl.message(
      'The Website URL copied to clipboard',
      name: 'contact_clipboard_website',
      desc: '',
      args: [],
    );
  }

  /// `Cannot open the email address`
  String get contact_error_email {
    return Intl.message(
      'Cannot open the email address',
      name: 'contact_error_email',
      desc: '',
      args: [],
    );
  }

  /// `Cannot open the phone number`
  String get contact_error_phone {
    return Intl.message(
      'Cannot open the phone number',
      name: 'contact_error_phone',
      desc: '',
      args: [],
    );
  }

  /// `Cannot open the website`
  String get contact_error_website {
    return Intl.message(
      'Cannot open the website',
      name: 'contact_error_website',
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

  /// `An email has been sent, please check your email.`
  String get email_sent {
    return Intl.message(
      'An email has been sent, please check your email.',
      name: 'email_sent',
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

  /// `Surveys involve conducting patrols along the beach to detect possible traces of turtle nesting during the period between June 1st and October 31st.`
  String get how_to_1_1 {
    return Intl.message(
      'Surveys involve conducting patrols along the beach to detect possible traces of turtle nesting during the period between June 1st and October 31st.',
      name: 'how_to_1_1',
      desc: '',
      args: [],
    );
  }

  /// `It is recommended to carry out these patrols between 22:00 h and 8:00 h of the following day, although the early hours of the night are the most suitable for`
  String get how_to_1_2 {
    return Intl.message(
      'It is recommended to carry out these patrols between 22:00 h and 8:00 h of the following day, although the early hours of the night are the most suitable for',
      name: 'how_to_1_2',
      desc: '',
      args: [],
    );
  }

  /// `Transects`
  String get how_to_1_title {
    return Intl.message(
      'Transects',
      name: 'how_to_1_title',
      desc: '',
      args: [],
    );
  }

  /// `When a turtle emerges from the sea onto the beach to nest, it crawls using its flippers as if they were legs. This movement leaves a very distinctive track ascending towards the beach.`
  String get how_to_2_1 {
    return Intl.message(
      'When a turtle emerges from the sea onto the beach to nest, it crawls using its flippers as if they were legs. This movement leaves a very distinctive track ascending towards the beach.',
      name: 'how_to_2_1',
      desc: '',
      args: [],
    );
  }

  /// `When it finds the suitable place, it digs the nest, lays the eggs, covers it, and returns to the sea, leaving a track with the same characteristics as the ascent but in the direction of the sea. Often with a line in the middle to drag the tube through which the eggs have come out.`
  String get how_to_2_2 {
    return Intl.message(
      'When it finds the suitable place, it digs the nest, lays the eggs, covers it, and returns to the sea, leaving a track with the same characteristics as the ascent but in the direction of the sea. Often with a line in the middle to drag the tube through which the eggs have come out.',
      name: 'how_to_2_2',
      desc: '',
      args: [],
    );
  }

  /// `The ascent track may undergo changes in direction ascending, motivated by the turtle's search for the suitable place to dig the nest. The descent track is always more straight, direct towards the sea.`
  String get how_to_2_3 {
    return Intl.message(
      'The ascent track may undergo changes in direction ascending, motivated by the turtle\'s search for the suitable place to dig the nest. The descent track is always more straight, direct towards the sea.',
      name: 'how_to_2_3',
      desc: '',
      args: [],
    );
  }

  /// `What are we looking for?`
  String get how_to_2_title {
    return Intl.message(
      'What are we looking for?',
      name: 'how_to_2_title',
      desc: '',
      args: [],
    );
  }

  /// `Even more challenging would be to encounter, between August and October, hatchlings coming out of undetected nests and walking on the sand towards the beach. This is an extremely low probability considering that they hatch at night and due to their small size.`
  String get how_to_3_1 {
    return Intl.message(
      'Even more challenging would be to encounter, between August and October, hatchlings coming out of undetected nests and walking on the sand towards the beach. This is an extremely low probability considering that they hatch at night and due to their small size.',
      name: 'how_to_3_1',
      desc: '',
      args: [],
    );
  }

  /// `If we find small hatchlings or a large turtle alive or dead outside the water, we should quickly call 112`
  String get how_to_3_2 {
    return Intl.message(
      'If we find small hatchlings or a large turtle alive or dead outside the water, we should quickly call 112',
      name: 'how_to_3_2',
      desc: '',
      args: [],
    );
  }

  /// `What are we looking for?`
  String get how_to_3_title {
    return Intl.message(
      'What are we looking for?',
      name: 'how_to_3_title',
      desc: '',
      args: [],
    );
  }

  /// `You can bring a flashlight or headlamp with a red light, although it is rarely necessary for walking; we will use it if we are unsure about something during the transect, moonlight is usually sufficient. Whenever possible, we will keep the flashlight off and walk quietly. If we do not have enough light to observe tracks, we will have to place the flashlight with the arm stretched towards the ground so that the illumination highlights the sand relief better. We should never point the flashlight towards the water, as it could scare off a turtle if there is one trying to come out.`
  String get how_to_4_1 {
    return Intl.message(
      'You can bring a flashlight or headlamp with a red light, although it is rarely necessary for walking; we will use it if we are unsure about something during the transect, moonlight is usually sufficient. Whenever possible, we will keep the flashlight off and walk quietly. If we do not have enough light to observe tracks, we will have to place the flashlight with the arm stretched towards the ground so that the illumination highlights the sand relief better. We should never point the flashlight towards the water, as it could scare off a turtle if there is one trying to come out.',
      name: 'how_to_4_1',
      desc: '',
      args: [],
    );
  }

  /// `You can put red cellophane paper on a flashlight or in front of the mobile phone flashlight.`
  String get how_to_4_2 {
    return Intl.message(
      'You can put red cellophane paper on a flashlight or in front of the mobile phone flashlight.',
      name: 'how_to_4_2',
      desc: '',
      args: [],
    );
  }

  /// `Lightning`
  String get how_to_4_title {
    return Intl.message(
      'Lightning',
      name: 'how_to_4_title',
      desc: '',
      args: [],
    );
  }

  /// `Podemos aprovechar el paseo para informar y sensibilizar a las personas o grupos de  personas que nos encontramos en la playa (deportistas, familias, pescadores/as de caña y otras personas) para que nos ayuden llamando al 112 si son testigos de una nidificación o encuentran rastros. Siempre bajo nuestro criterio y voluntad.`
  String get how_to_5_1 {
    return Intl.message(
      'Podemos aprovechar el paseo para informar y sensibilizar a las personas o grupos de  personas que nos encontramos en la playa (deportistas, familias, pescadores/as de caña y otras personas) para que nos ayuden llamando al 112 si son testigos de una nidificación o encuentran rastros. Siempre bajo nuestro criterio y voluntad.',
      name: 'how_to_5_1',
      desc: '',
      args: [],
    );
  }

  /// `Sensitization`
  String get how_to_5_title {
    return Intl.message(
      'Sensitization',
      name: 'how_to_5_title',
      desc: '',
      args: [],
    );
  }

  /// `We will start the transect in a specific area of the beach and activate the "START TRANSECT" button.`
  String get how_to_6_1 {
    return Intl.message(
      'We will start the transect in a specific area of the beach and activate the "START TRANSECT" button.',
      name: 'how_to_6_1',
      desc: '',
      args: [],
    );
  }

  /// `We will walk along the beach, by the seashore, observing the first meters of undulating dry sand.`
  String get how_to_6_2 {
    return Intl.message(
      'We will walk along the beach, by the seashore, observing the first meters of undulating dry sand.',
      name: 'how_to_6_2',
      desc: '',
      args: [],
    );
  }

  /// `Start transect`
  String get how_to_6_title {
    return Intl.message(
      'Start transect',
      name: 'how_to_6_title',
      desc: '',
      args: [],
    );
  }

  /// `Once we finish our route, we will access the section "START TRANSECT" and press "FINISH TRANSECT," which will take us to a screen where we must fill in the following fields: If we found the beach plowed by a machine that could erase the tracks. Record the number of people informed. Note interesting observations. And press send.`
  String get how_to_7_1 {
    return Intl.message(
      'Once we finish our route, we will access the section "START TRANSECT" and press "FINISH TRANSECT," which will take us to a screen where we must fill in the following fields: If we found the beach plowed by a machine that could erase the tracks. Record the number of people informed. Note interesting observations. And press send.',
      name: 'how_to_7_1',
      desc: '',
      args: [],
    );
  }

  /// `Finish transect`
  String get how_to_7_title {
    return Intl.message(
      'Finish transect',
      name: 'how_to_7_title',
      desc: '',
      args: [],
    );
  }

  /// `Become a volunteer`
  String get how_to_8_title {
    return Intl.message(
      'Become a volunteer',
      name: 'how_to_8_title',
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

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `If you press the 'cancel' button, all data regarding the current transect will be lost`
  String get note_cancel {
    return Intl.message(
      'If you press the \'cancel\' button, all data regarding the current transect will be lost',
      name: 'note_cancel',
      desc: '',
      args: [],
    );
  }

  /// `If you want to continue with the current transect you must press the button at the top left to go back`
  String get note_go_back {
    return Intl.message(
      'If you want to continue with the current transect you must press the button at the top left to go back',
      name: 'note_go_back',
      desc: '',
      args: [],
    );
  }

  /// `If you press the 'send' button the data for the current transect will be sent and you will have to start a new transect.`
  String get note_send {
    return Intl.message(
      'If you press the \'send\' button the data for the current transect will be sent and you will have to start a new transect.',
      name: 'note_send',
      desc: '',
      args: [],
    );
  }

  /// `Observations`
  String get observations {
    return Intl.message(
      'Observations',
      name: 'observations',
      desc: '',
      args: [],
    );
  }

  /// `PREVIOUS`
  String get page_back {
    return Intl.message(
      'PREVIOUS',
      name: 'page_back',
      desc: '',
      args: [],
    );
  }

  /// `NEXT`
  String get page_next {
    return Intl.message(
      'NEXT',
      name: 'page_next',
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

  /// `Number of people informed`
  String get people_informed {
    return Intl.message(
      'Number of people informed',
      name: 'people_informed',
      desc: '',
      args: [],
    );
  }

  /// `Enviar`
  String get send {
    return Intl.message(
      'Enviar',
      name: 'send',
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

  /// `Stop a transect`
  String get stop_transect {
    return Intl.message(
      'Stop a transect',
      name: 'stop_transect',
      desc: '',
      args: [],
    );
  }

  /// `Has the tractor passed?`
  String get tractor {
    return Intl.message(
      'Has the tractor passed?',
      name: 'tractor',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the following fields`
  String get transect_form {
    return Intl.message(
      'Fill in the following fields',
      name: 'transect_form',
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

  /// `GPS services is disabled`
  String get gps_service_disabled {
    return Intl.message(
      'GPS services is disabled',
      name: 'gps_service_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Enable GPS service and go back`
  String get gps_services_enable_gps {
    return Intl.message(
      'Enable GPS service and go back',
      name: 'gps_services_enable_gps',
      desc: '',
      args: [],
    );
  }

  /// `Enable GPS service and go back`
  String get add_new_geopoint {
    return Intl.message(
      'Enable GPS service and go back',
      name: 'add_new_geopoint',
      desc: '',
      args: [],
    );
  }

  /// `Someting went wrong, please try again`
  String get something_wrong_try_again {
    return Intl.message(
      'Someting went wrong, please try again',
      name: 'something_wrong_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Running in Background`
  String get app_background_notification_title {
    return Intl.message(
      'Running in Background',
      name: 'app_background_notification_title',
      desc: '',
      args: [],
    );
  }

  /// `Transecte app will continue to receive your location even when you aren't using it`
  String get app_background_notification_text {
    return Intl.message(
      'Transecte app will continue to receive your location even when you aren\'t using it',
      name: 'app_background_notification_text',
      desc: '',
      args: [],
    );
  }

  /// `GPS background service disabled`
  String get gps_service_background_disabled {
    return Intl.message(
      'GPS background service disabled',
      name: 'gps_service_background_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Please go to app settings (OS) an enable GPS service to: 'ALWAYS' and relaunch the app`
  String get gps_service_background_disabled_content {
    return Intl.message(
      'Please go to app settings (OS) an enable GPS service to: \'ALWAYS\' and relaunch the app',
      name: 'gps_service_background_disabled_content',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Technician`
  String get technician {
    return Intl.message(
      'Technician',
      name: 'technician',
      desc: '',
      args: [],
    );
  }

  /// `Open system settings`
  String get open_system_settings {
    return Intl.message(
      'Open system settings',
      name: 'open_system_settings',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get delete_account {
    return Intl.message(
      'Delete account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Tis action cannot be undone!!! Please logout and login before deleting user`
  String get delete_account_content {
    return Intl.message(
      'Tis action cannot be undone!!! Please logout and login before deleting user',
      name: 'delete_account_content',
      desc: '',
      args: [],
    );
  }

  /// `If you continue, the information will be lost and cannot be recovered.`
  String get cancel_transect {
    return Intl.message(
      'If you continue, the information will be lost and cannot be recovered.',
      name: 'cancel_transect',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `If you continue, the information will be saved and cannot be modified.`
  String get save_transect {
    return Intl.message(
      'If you continue, the information will be saved and cannot be modified.',
      name: 'save_transect',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Remove all transects`
  String get delete_all_transects {
    return Intl.message(
      'Remove all transects',
      name: 'delete_all_transects',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone, be careful!`
  String get delete_all_transects_content {
    return Intl.message(
      'This action cannot be undone, be careful!',
      name: 'delete_all_transects_content',
      desc: '',
      args: [],
    );
  }

  /// `Add new marks`
  String get add_new_marks {
    return Intl.message(
      'Add new marks',
      name: 'add_new_marks',
      desc: '',
      args: [],
    );
  }

  /// `City or datetime (YYYY-MM-DDTHH:MM:SS)`
  String get filter_hint {
    return Intl.message(
      'City or datetime (YYYY-MM-DDTHH:MM:SS)',
      name: 'filter_hint',
      desc: '',
      args: [],
    );
  }

  /// `Clear filter`
  String get filter_clear {
    return Intl.message(
      'Clear filter',
      name: 'filter_clear',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Transect detail`
  String get transect_detail {
    return Intl.message(
      'Transect detail',
      name: 'transect_detail',
      desc: '',
      args: [],
    );
  }

  /// `Author`
  String get transect_author {
    return Intl.message(
      'Author',
      name: 'transect_author',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get transect_date {
    return Intl.message(
      'Date',
      name: 'transect_date',
      desc: '',
      args: [],
    );
  }

  /// `Administrative area`
  String get transect_administrative_are {
    return Intl.message(
      'Administrative area',
      name: 'transect_administrative_are',
      desc: '',
      args: [],
    );
  }

  /// `Subadministrative area`
  String get transect_subadministrative_are {
    return Intl.message(
      'Subadministrative area',
      name: 'transect_subadministrative_are',
      desc: '',
      args: [],
    );
  }

  /// `Locality`
  String get transect_locality {
    return Intl.message(
      'Locality',
      name: 'transect_locality',
      desc: '',
      args: [],
    );
  }

  /// `People informed`
  String get transect_people_informed {
    return Intl.message(
      'People informed',
      name: 'transect_people_informed',
      desc: '',
      args: [],
    );
  }

  /// `Has the tractor passed?`
  String get transect_tractor {
    return Intl.message(
      'Has the tractor passed?',
      name: 'transect_tractor',
      desc: '',
      args: [],
    );
  }

  /// `Observations`
  String get transect_observations {
    return Intl.message(
      'Observations',
      name: 'transect_observations',
      desc: '',
      args: [],
    );
  }

  /// `Filed saved:`
  String get file_saved {
    return Intl.message(
      'Filed saved:',
      name: 'file_saved',
      desc: '',
      args: [],
    );
  }

  /// `Transect cannot be safe due to coordinates is empty`
  String get snackbar_error_empty_coordinates {
    return Intl.message(
      'Transect cannot be safe due to coordinates is empty',
      name: 'snackbar_error_empty_coordinates',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while trying to delete your account`
  String get snackbar_error_delete_account {
    return Intl.message(
      'An error occurred while trying to delete your account',
      name: 'snackbar_error_delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Please logout and login before deleting your account`
  String get snackbar_error_requires_recent_login {
    return Intl.message(
      'Please logout and login before deleting your account',
      name: 'snackbar_error_requires_recent_login',
      desc: '',
      args: [],
    );
  }

  /// `Pls verify your account. An email with instructions has been send`
  String get snackbar_error_verify_account {
    return Intl.message(
      'Pls verify your account. An email with instructions has been send',
      name: 'snackbar_error_verify_account',
      desc: '',
      args: [],
    );
  }

  /// `See transect on map`
  String get open_map {
    return Intl.message(
      'See transect on map',
      name: 'open_map',
      desc: '',
      args: [],
    );
  }

  /// `Transects`
  String get transects {
    return Intl.message(
      'Transects',
      name: 'transects',
      desc: '',
      args: [],
    );
  }

  /// `All Transects`
  String get all_transects {
    return Intl.message(
      'All Transects',
      name: 'all_transects',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
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
