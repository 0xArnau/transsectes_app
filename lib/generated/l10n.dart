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

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Account removed`
  String get accountRemoved {
    return Intl.message(
      'Account removed',
      name: 'accountRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Add new geopoint`
  String get add_new_geopoint {
    return Intl.message(
      'Add new geopoint',
      name: 'add_new_geopoint',
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

  /// `All legal fields must be accepted.`
  String get allLegalFieldsMustBeAccepted {
    return Intl.message(
      'All legal fields must be accepted.',
      name: 'allLegalFieldsMustBeAccepted',
      desc: '',
      args: [],
    );
  }

  /// `All transects deleted successfully!`
  String get allTransectsDeleted {
    return Intl.message(
      'All transects deleted successfully!',
      name: 'allTransectsDeleted',
      desc: '',
      args: [],
    );
  }

  /// `All transects loaded successfully.`
  String get allTransectsLoadedSuccessfully {
    return Intl.message(
      'All transects loaded successfully.',
      name: 'allTransectsLoadedSuccessfully',
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

  /// `The app has been created by Arnau for GePeC-EdC.`
  String get appCreatedBy {
    return Intl.message(
      'The app has been created by Arnau for GePeC-EdC.',
      name: 'appCreatedBy',
      desc: '',
      args: [],
    );
  }

  /// `Creator`
  String get appCreator {
    return Intl.message(
      'Creator',
      name: 'appCreator',
      desc: '',
      args: [],
    );
  }

  /// `App Info`
  String get appInfo {
    return Intl.message(
      'App Info',
      name: 'appInfo',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get appName {
    return Intl.message(
      'Name',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `App is running in the background`
  String get appRunningInBackground {
    return Intl.message(
      'App is running in the background',
      name: 'appRunningInBackground',
      desc: '',
      args: [],
    );
  }

  /// `Source Code`
  String get appSourceCode {
    return Intl.message(
      'Source Code',
      name: 'appSourceCode',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get appVersion {
    return Intl.message(
      'Version',
      name: 'appVersion',
      desc: '',
      args: [],
    );
  }

  /// `Transect app will continue to receive your location even when you aren't using it`
  String get app_background_notification_text {
    return Intl.message(
      'Transect app will continue to receive your location even when you aren\'t using it',
      name: 'app_background_notification_text',
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

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Build Number`
  String get buildNumber {
    return Intl.message(
      'Build Number',
      name: 'buildNumber',
      desc: '',
      args: [],
    );
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

  /// `If you continue, the information will be lost and cannot be recovered.`
  String get cancel_transect {
    return Intl.message(
      'If you continue, the information will be lost and cannot be recovered.',
      name: 'cancel_transect',
      desc: '',
      args: [],
    );
  }

  /// `Cannot sign in.`
  String get cannotSignIn {
    return Intl.message(
      'Cannot sign in.',
      name: 'cannotSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Cannot sign out. Please try again.`
  String get cannotSignOutTryAgain {
    return Intl.message(
      'Cannot sign out. Please try again.',
      name: 'cannotSignOutTryAgain',
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

  /// `You can't stop a transect, there isn't one that's started.`
  String get cannot_stop_transect {
    return Intl.message(
      'You can\'t stop a transect, there isn\'t one that\'s started.',
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

  /// `Chart`
  String get chart {
    return Intl.message(
      'Chart',
      name: 'chart',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
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

  /// `Website URL copied to clipboard`
  String get contact_clipboard_website {
    return Intl.message(
      'Website URL copied to clipboard',
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

  /// `Current user is missing.`
  String get currentUserMissing {
    return Intl.message(
      'Current user is missing.',
      name: 'currentUserMissing',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
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

  /// `Delete account`
  String get delete_account {
    return Intl.message(
      'Delete account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone! Please log out and log in before deleting the user.`
  String get delete_account_content {
    return Intl.message(
      'This action cannot be undone! Please log out and log in before deleting the user.',
      name: 'delete_account_content',
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

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
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

  /// `Email sent`
  String get emailSent {
    return Intl.message(
      'Email sent',
      name: 'emailSent',
      desc: '',
      args: [],
    );
  }

  /// `Email status reloaded!`
  String get emailStatusReloaded {
    return Intl.message(
      'Email status reloaded!',
      name: 'emailStatusReloaded',
      desc: '',
      args: [],
    );
  }

  /// `An email has been sent. Please check your email.`
  String get email_sent {
    return Intl.message(
      'An email has been sent. Please check your email.',
      name: 'email_sent',
      desc: '',
      args: [],
    );
  }

  /// `Emails must be the same.`
  String get emailsMustBeTheSame {
    return Intl.message(
      'Emails must be the same.',
      name: 'emailsMustBeTheSame',
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

  /// `(end)`
  String get endPoint {
    return Intl.message(
      '(end)',
      name: 'endPoint',
      desc: '',
      args: [],
    );
  }

  /// `Error, cannot sign out`
  String get errorCannotSignOut {
    return Intl.message(
      'Error, cannot sign out',
      name: 'errorCannotSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Error: No coordinates available to generate the URL.`
  String get errorNoCoordinatesForURL {
    return Intl.message(
      'Error: No coordinates available to generate the URL.',
      name: 'errorNoCoordinatesForURL',
      desc: '',
      args: [],
    );
  }

  /// `Error reloading email status`
  String get errorReloadingEmailStatus {
    return Intl.message(
      'Error reloading email status',
      name: 'errorReloadingEmailStatus',
      desc: '',
      args: [],
    );
  }

  /// `Error sending the email`
  String get errorSendingEmail {
    return Intl.message(
      'Error sending the email',
      name: 'errorSendingEmail',
      desc: '',
      args: [],
    );
  }

  /// `Error sending verification email`
  String get errorSendingVerificationEmail {
    return Intl.message(
      'Error sending verification email',
      name: 'errorSendingVerificationEmail',
      desc: '',
      args: [],
    );
  }

  /// `There has been an error while checking if the user is authenticated.`
  String get errorWhileCheckingIfUserIsAuthenticated {
    return Intl.message(
      'There has been an error while checking if the user is authenticated.',
      name: 'errorWhileCheckingIfUserIsAuthenticated',
      desc: '',
      args: [],
    );
  }

  /// `There has been an error while checking if the user is a technician or not.`
  String get errorWhileCheckingUserIsTechnician {
    return Intl.message(
      'There has been an error while checking if the user is a technician or not.',
      name: 'errorWhileCheckingUserIsTechnician',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting transects!`
  String get errorWhileDeletingTransects {
    return Intl.message(
      'An error occurred while deleting transects!',
      name: 'errorWhileDeletingTransects',
      desc: '',
      args: [],
    );
  }

  /// `There has been an error while getting the current user.`
  String get errorWhileGettingCurrentUser {
    return Intl.message(
      'There has been an error while getting the current user.',
      name: 'errorWhileGettingCurrentUser',
      desc: '',
      args: [],
    );
  }

  /// `Error while saving the transects.`
  String get errorWhileSavingTransects {
    return Intl.message(
      'Error while saving the transects.',
      name: 'errorWhileSavingTransects',
      desc: '',
      args: [],
    );
  }

  /// `Error while starting a transect.`
  String get errorWhileStartingTransect {
    return Intl.message(
      'Error while starting a transect.',
      name: 'errorWhileStartingTransect',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load transects.`
  String get failedToLoadTransects {
    return Intl.message(
      'Failed to load transects.',
      name: 'failedToLoadTransects',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load user transects.`
  String get failedToLoadUserTransects {
    return Intl.message(
      'Failed to load user transects.',
      name: 'failedToLoadUserTransects',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update transect.`
  String get failedToUpdateTransect {
    return Intl.message(
      'Failed to update transect.',
      name: 'failedToUpdateTransect',
      desc: '',
      args: [],
    );
  }

  /// `File saved:`
  String get file_saved {
    return Intl.message(
      'File saved:',
      name: 'file_saved',
      desc: '',
      args: [],
    );
  }

  /// `File saved at 'Files > Menu > device name > Android > data > cat.gepec.transsectes_app > files > {fileName}'`
  String file_saved_android(Object fileName) {
    return Intl.message(
      'File saved at \'Files > Menu > device name > Android > data > cat.gepec.transsectes_app > files > $fileName\'',
      name: 'file_saved_android',
      desc: '',
      args: [fileName],
    );
  }

  /// `File saved: {fileName}`
  String file_saved_generic(Object fileName) {
    return Intl.message(
      'File saved: $fileName',
      name: 'file_saved_generic',
      desc: '',
      args: [fileName],
    );
  }

  /// `File saved at 'Files > Browse > On My iPhone > Transsectes > {fileName}'`
  String file_saved_ios(Object fileName) {
    return Intl.message(
      'File saved at \'Files > Browse > On My iPhone > Transsectes > $fileName\'',
      name: 'file_saved_ios',
      desc: '',
      args: [fileName],
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

  /// `City or datetime (YYYY-MM-DDTHH:MM:SS)`
  String get filter_hint {
    return Intl.message(
      'City or datetime (YYYY-MM-DDTHH:MM:SS)',
      name: 'filter_hint',
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

  /// `Google Maps URL copied to clipboard!`
  String get googleMapsURLCopied {
    return Intl.message(
      'Google Maps URL copied to clipboard!',
      name: 'googleMapsURLCopied',
      desc: '',
      args: [],
    );
  }

  /// `GPS Permission Denied`
  String get gpsPermissionDenied {
    return Intl.message(
      'GPS Permission Denied',
      name: 'gpsPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `GPS service is disabled, please enable it before continuing`
  String get gpsServiceDisabled {
    return Intl.message(
      'GPS service is disabled, please enable it before continuing',
      name: 'gpsServiceDisabled',
      desc: '',
      args: [],
    );
  }

  /// `The GPS service is disabled. Please enable GPS to continue.`
  String get gpsServiceDisabledMessage {
    return Intl.message(
      'The GPS service is disabled. Please enable GPS to continue.',
      name: 'gpsServiceDisabledMessage',
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

  /// `Please go to app settings (OS) and enable GPS service to 'ALWAYS' and relaunch the app`
  String get gps_service_background_disabled_content {
    return Intl.message(
      'Please go to app settings (OS) and enable GPS service to \'ALWAYS\' and relaunch the app',
      name: 'gps_service_background_disabled_content',
      desc: '',
      args: [],
    );
  }

  /// `GPS service is disabled`
  String get gps_service_disabled {
    return Intl.message(
      'GPS service is disabled',
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

  /// `Hide`
  String get hide {
    return Intl.message(
      'Hide',
      name: 'hide',
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

  /// `It is recommended to carry out these patrols between 22:00 and 8:00 the following day, although the early hours of the night are the most suitable for`
  String get how_to_1_2 {
    return Intl.message(
      'It is recommended to carry out these patrols between 22:00 and 8:00 the following day, although the early hours of the night are the most suitable for',
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

  /// `When it finds a suitable place, it digs the nest, lays the eggs, covers it, and returns to the sea, leaving a track with the same characteristics as the ascent but in the direction of the sea, often with a line in the middle to drag the tube through which the eggs have come out.`
  String get how_to_2_2 {
    return Intl.message(
      'When it finds a suitable place, it digs the nest, lays the eggs, covers it, and returns to the sea, leaving a track with the same characteristics as the ascent but in the direction of the sea, often with a line in the middle to drag the tube through which the eggs have come out.',
      name: 'how_to_2_2',
      desc: '',
      args: [],
    );
  }

  /// `The ascent track may change direction as the turtle searches for a suitable place to dig the nest. The descent track is always more straight, heading directly towards the sea.`
  String get how_to_2_3 {
    return Intl.message(
      'The ascent track may change direction as the turtle searches for a suitable place to dig the nest. The descent track is always more straight, heading directly towards the sea.',
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

  /// `Even more challenging would be to encounter hatchlings between August and October, emerging from undetected nests and walking on the sand towards the beach. This is extremely unlikely as they hatch at night and are very small.`
  String get how_to_3_1 {
    return Intl.message(
      'Even more challenging would be to encounter hatchlings between August and October, emerging from undetected nests and walking on the sand towards the beach. This is extremely unlikely as they hatch at night and are very small.',
      name: 'how_to_3_1',
      desc: '',
      args: [],
    );
  }

  /// `If we find small hatchlings or a large turtle alive or dead outside the water, we should quickly call 112.`
  String get how_to_3_2 {
    return Intl.message(
      'If we find small hatchlings or a large turtle alive or dead outside the water, we should quickly call 112.',
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

  /// `You can bring a flashlight or headlamp with a red light, although it is rarely necessary for walking. We will use it if we are unsure about something during the transect, but moonlight is usually sufficient. Whenever possible, keep the flashlight off and walk quietly. If we do not have enough light to observe tracks, we will hold the flashlight with our arm extended towards the ground to highlight the sand relief better. Never point the flashlight towards the water, as it could scare off a turtle if there is one trying to come out.`
  String get how_to_4_1 {
    return Intl.message(
      'You can bring a flashlight or headlamp with a red light, although it is rarely necessary for walking. We will use it if we are unsure about something during the transect, but moonlight is usually sufficient. Whenever possible, keep the flashlight off and walk quietly. If we do not have enough light to observe tracks, we will hold the flashlight with our arm extended towards the ground to highlight the sand relief better. Never point the flashlight towards the water, as it could scare off a turtle if there is one trying to come out.',
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

  /// `Lighting`
  String get how_to_4_title {
    return Intl.message(
      'Lighting',
      name: 'how_to_4_title',
      desc: '',
      args: [],
    );
  }

  /// `We can take advantage of the walk to inform and raise awareness among people or groups we encounter on the beach (athletes, families, anglers, and others) to help us by calling 112 if they witness a nesting or find tracks. Always at our discretion and willingness.`
  String get how_to_5_1 {
    return Intl.message(
      'We can take advantage of the walk to inform and raise awareness among people or groups we encounter on the beach (athletes, families, anglers, and others) to help us by calling 112 if they witness a nesting or find tracks. Always at our discretion and willingness.',
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

  /// `Once we finish our route, we will access the section "START TRANSECT" and press "FINISH TRANSECT," which will take us to a screen where we must fill in the following fields: if we found the beach plowed by a machine that could erase the tracks, record the number of people informed, note interesting observations, and press send.`
  String get how_to_7_1 {
    return Intl.message(
      'Once we finish our route, we will access the section "START TRANSECT" and press "FINISH TRANSECT," which will take us to a screen where we must fill in the following fields: if we found the beach plowed by a machine that could erase the tracks, record the number of people informed, note interesting observations, and press send.',
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

  /// `Informative clause`
  String get informativeClause {
    return Intl.message(
      'Informative clause',
      name: 'informativeClause',
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

  /// `Invalid email`
  String get invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `To change the language permanently, you need to adjust the language settings on your device.`
  String get language_change {
    return Intl.message(
      'To change the language permanently, you need to adjust the language settings on your device.',
      name: 'language_change',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get language_change_2 {
    return Intl.message(
      'Change language',
      name: 'language_change_2',
      desc: '',
      args: [],
    );
  }

  /// `This is a temporary change`
  String get language_change_2_temporal {
    return Intl.message(
      'This is a temporary change',
      name: 'language_change_2_temporal',
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

  /// `Legal notice`
  String get legalNotice {
    return Intl.message(
      'Legal notice',
      name: 'legalNotice',
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

  /// `List`
  String get list {
    return Intl.message(
      'List',
      name: 'list',
      desc: '',
      args: [],
    );
  }

  /// `Location background permissions are permanently denied`
  String get locationBackgroundPermissionsDenied {
    return Intl.message(
      'Location background permissions are permanently denied',
      name: 'locationBackgroundPermissionsDenied',
      desc: '',
      args: [],
    );
  }

  /// `Location permissions are not granted`
  String get locationPermissionsNotGranted {
    return Intl.message(
      'Location permissions are not granted',
      name: 'locationPermissionsNotGranted',
      desc: '',
      args: [],
    );
  }

  /// `Location permissions are permanently denied.`
  String get locationPermissionsPermanentlyDenied {
    return Intl.message(
      'Location permissions are permanently denied.',
      name: 'locationPermissionsPermanentlyDenied',
      desc: '',
      args: [],
    );
  }

  /// `Please go to the settings and enable 'Always' for location access.`
  String get locationPermissionsSettingsMessage {
    return Intl.message(
      'Please go to the settings and enable \'Always\' for location access.',
      name: 'locationPermissionsSettingsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Location Service`
  String get locationService {
    return Intl.message(
      'Location Service',
      name: 'locationService',
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

  /// `Metrics`
  String get metrics {
    return Intl.message(
      'Metrics',
      name: 'metrics',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `No transects available.`
  String get noTransectsAvailable {
    return Intl.message(
      'No transects available.',
      name: 'noTransectsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No user is currently authenticated.`
  String get noUserAuthenticated {
    return Intl.message(
      'No user is currently authenticated.',
      name: 'noUserAuthenticated',
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

  /// `If you press the 'cancel' button, all data regarding the current transect will be lost.`
  String get note_cancel {
    return Intl.message(
      'If you press the \'cancel\' button, all data regarding the current transect will be lost.',
      name: 'note_cancel',
      desc: '',
      args: [],
    );
  }

  /// `If you want to continue with the current transect, you must press the button at the top left to go back.`
  String get note_go_back {
    return Intl.message(
      'If you want to continue with the current transect, you must press the button at the top left to go back.',
      name: 'note_go_back',
      desc: '',
      args: [],
    );
  }

  /// `If you press the 'send' button, the data for the current transect will be sent, and you will have to start a new transect.`
  String get note_send {
    return Intl.message(
      'If you press the \'send\' button, the data for the current transect will be sent, and you will have to start a new transect.',
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

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
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

  /// `Open system settings`
  String get open_system_settings {
    return Intl.message(
      'Open system settings',
      name: 'open_system_settings',
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

  /// `Password must be the same.`
  String get passwordMustBeTheSame {
    return Intl.message(
      'Password must be the same.',
      name: 'passwordMustBeTheSame',
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

  /// `Privacy`
  String get privacy {
    return Intl.message(
      'Privacy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get reload {
    return Intl.message(
      'Reload',
      name: 'reload',
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

  /// `Requesting GPS Permissions`
  String get requestingGpsPermissions {
    return Intl.message(
      'Requesting GPS Permissions',
      name: 'requestingGpsPermissions',
      desc: '',
      args: [],
    );
  }

  /// `Requires a non-technician to perform this action.`
  String get requiresNonTechnician {
    return Intl.message(
      'Requires a non-technician to perform this action.',
      name: 'requiresNonTechnician',
      desc: '',
      args: [],
    );
  }

  /// `Resume`
  String get resume {
    return Intl.message(
      'Resume',
      name: 'resume',
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

  /// `If you continue, the information will be saved and cannot be modified.`
  String get save_transect {
    return Intl.message(
      'If you continue, the information will be saved and cannot be modified.',
      name: 'save_transect',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Send Verification Email`
  String get sendVerificationEmail {
    return Intl.message(
      'Send Verification Email',
      name: 'sendVerificationEmail',
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

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Sign out successfully!`
  String get signOutSuccessfully {
    return Intl.message(
      'Sign out successfully!',
      name: 'signOutSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Sign up successful. Click to 'Send verification email'`
  String get signUpSuccessfulClickToSendVerificationEmail {
    return Intl.message(
      'Sign up successful. Click to \'Send verification email\'',
      name: 'signUpSuccessfulClickToSendVerificationEmail',
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

  /// `An error occurred while trying to delete your account`
  String get snackbar_error_delete_account {
    return Intl.message(
      'An error occurred while trying to delete your account',
      name: 'snackbar_error_delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Transect cannot be saved because coordinates are empty`
  String get snackbar_error_empty_coordinates {
    return Intl.message(
      'Transect cannot be saved because coordinates are empty',
      name: 'snackbar_error_empty_coordinates',
      desc: '',
      args: [],
    );
  }

  /// `Please log out and log in before deleting your account`
  String get snackbar_error_requires_recent_login {
    return Intl.message(
      'Please log out and log in before deleting your account',
      name: 'snackbar_error_requires_recent_login',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your account. An email with instructions has been sent`
  String get snackbar_error_verify_account {
    return Intl.message(
      'Please verify your account. An email with instructions has been sent',
      name: 'snackbar_error_verify_account',
      desc: '',
      args: [],
    );
  }

  /// `Some fields are empty.`
  String get someFieldsAreEmpty {
    return Intl.message(
      'Some fields are empty.',
      name: 'someFieldsAreEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again`
  String get something_wrong_try_again {
    return Intl.message(
      'Something went wrong, please try again',
      name: 'something_wrong_try_again',
      desc: '',
      args: [],
    );
  }

  /// `(start)`
  String get startPoint {
    return Intl.message(
      '(start)',
      name: 'startPoint',
      desc: '',
      args: [],
    );
  }

  /// `Start/Stop Transect`
  String get startStopTransect {
    return Intl.message(
      'Start/Stop Transect',
      name: 'startStopTransect',
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

  /// `Started a transect.`
  String get startedATransect {
    return Intl.message(
      'Started a transect.',
      name: 'startedATransect',
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

  /// `Technician`
  String get technician {
    return Intl.message(
      'Technician',
      name: 'technician',
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

  /// `Transect stopped.`
  String get transectStopped {
    return Intl.message(
      'Transect stopped.',
      name: 'transectStopped',
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

  /// `Transect detail`
  String get transect_detail {
    return Intl.message(
      'Transect detail',
      name: 'transect_detail',
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

  /// `Locality`
  String get transect_locality {
    return Intl.message(
      'Locality',
      name: 'transect_locality',
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

  /// `People informed`
  String get transect_people_informed {
    return Intl.message(
      'People informed',
      name: 'transect_people_informed',
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

  /// `Subadministrative area`
  String get transect_subadministrative_are {
    return Intl.message(
      'Subadministrative area',
      name: 'transect_subadministrative_are',
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

  /// `Transects`
  String get transects {
    return Intl.message(
      'Transects',
      name: 'transects',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error occurred. Please try again.`
  String get unexpectedErrorOccurred {
    return Intl.message(
      'Unexpected error occurred. Please try again.',
      name: 'unexpectedErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error. Cannot send email to restore password.`
  String get unexpectedErrorRestorePasswordEmail {
    return Intl.message(
      'Unexpected error. Cannot send email to restore password.',
      name: 'unexpectedErrorRestorePasswordEmail',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred while deleting the account.`
  String get unexpectedErrorWhileDeletingAccount {
    return Intl.message(
      'An unexpected error occurred while deleting the account.',
      name: 'unexpectedErrorWhileDeletingAccount',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error, cannot reload.`
  String get unknownErrorCannotReload {
    return Intl.message(
      'Unknown error, cannot reload.',
      name: 'unknownErrorCannotReload',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error, cannot create user account.`
  String get unknownErrorCreateUserAccount {
    return Intl.message(
      'Unknown error, cannot create user account.',
      name: 'unknownErrorCreateUserAccount',
      desc: '',
      args: [],
    );
  }

  /// `User email is missing.`
  String get userEmailMissing {
    return Intl.message(
      'User email is missing.',
      name: 'userEmailMissing',
      desc: '',
      args: [],
    );
  }

  /// `User icon`
  String get userIcon {
    return Intl.message(
      'User icon',
      name: 'userIcon',
      desc: '',
      args: [],
    );
  }

  /// `User must reauthenticate to delete their account.`
  String get userMustReauthenticate {
    return Intl.message(
      'User must reauthenticate to delete their account.',
      name: 'userMustReauthenticate',
      desc: '',
      args: [],
    );
  }

  /// `User disabled`
  String get user_disabled {
    return Intl.message(
      'User disabled',
      name: 'user_disabled',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get user_not_found {
    return Intl.message(
      'User not found',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `User's transects loaded successfully.`
  String get usersTransectsLoadedSuccessfully {
    return Intl.message(
      'User\'s transects loaded successfully.',
      name: 'usersTransectsLoadedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Verification email sent!`
  String get verificationEmailSent {
    return Intl.message(
      'Verification email sent!',
      name: 'verificationEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Verify Email`
  String get verifyEmail {
    return Intl.message(
      'Verify Email',
      name: 'verifyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Note: Weeks are from 1 to 7, 8 to 14, and so on. The day of the week is not considered.`
  String get weeklySubtitle {
    return Intl.message(
      'Note: Weeks are from 1 to 7, 8 to 14, and so on. The day of the week is not considered.',
      name: 'weeklySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get wrong_password {
    return Intl.message(
      'Wrong password',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get yearly {
    return Intl.message(
      'Yearly',
      name: 'yearly',
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
