import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MimicLocalizations {
  late Locale locale = const Locale('ar');
  MimicLocalizations(this.locale);

  static MimicLocalizations? of(BuildContext context) {
    return Localizations.of<MimicLocalizations>(context, MimicLocalizations);
  }

  late Map<String, String> _localizedValues;
  static List<Locale> supportedLocales = const [
    Locale('ar', ''),
    Locale('en', ''),
  ];
  static List<LocalizationsDelegate> localizationsDelegate = const [
    MimicLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  Future load() async {
    String jsonStringValues = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  //static

  static const LocalizationsDelegate<MimicLocalizations> delegate =
      _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<MimicLocalizations> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }

  @override
  Future<MimicLocalizations> load(Locale locale) async {
    // return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
    late MimicLocalizations localizations = MimicLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_DemoLocalizationsDelegate old) => false;
}
