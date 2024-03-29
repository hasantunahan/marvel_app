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

  /// `Page Not Found`
  String get view_page_not_found {
    return Intl.message(
      'Page Not Found',
      name: 'view_page_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Character List`
  String get marvel_character_list {
    return Intl.message(
      'Character List',
      name: 'marvel_character_list',
      desc: '',
      args: [],
    );
  }

  /// `Choose your marvel character`
  String get choose_character {
    return Intl.message(
      'Choose your marvel character',
      name: 'choose_character',
      desc: '',
      args: [],
    );
  }

  /// `He/She has not appeared in any comics after 2005.`
  String get after_2005_empty {
    return Intl.message(
      'He/She has not appeared in any comics after 2005.',
      name: 'after_2005_empty',
      desc: '',
      args: [],
    );
  }

  /// `Comics`
  String get comics {
    return Intl.message(
      'Comics',
      name: 'comics',
      desc: '',
      args: [],
    );
  }

  /// `Description not found..`
  String get description_not_found {
    return Intl.message(
      'Description not found..',
      name: 'description_not_found',
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
