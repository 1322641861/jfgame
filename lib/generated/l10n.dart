// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S(this.localeName);

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S(localeName);
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  final String localeName;

  String get appName {
    return Intl.message(
      'i10n_international',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  String get autoBySystem {
    return Intl.message(
      '自动',
      name: 'autoBySystem',
      desc: '',
      args: [],
    );
  }

  String get theme {
    return Intl.message(
      '主题颜色',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  String get settingLanguage {
    return Intl.message(
      '语言',
      name: 'settingLanguage',
      desc: '',
      args: [],
    );
  }

  String get darkMode {
    return Intl.message(
      '模式选择',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  String get language {
    return Intl.message(
      '语言',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  String get settingFont {
    return Intl.message(
      'System Font',
      name: 'settingFont',
      desc: '',
      args: [],
    );
  }

  String get fontKuaiLe {
    return Intl.message(
      'ZCOOL KuaiLe',
      name: 'fontKuaiLe',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('zh', 'CH'), // 语言，国家
      Locale('en', 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
