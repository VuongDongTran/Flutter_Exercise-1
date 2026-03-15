import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, dynamic>? _localizedStrings;
  
  // Static cache for global access
  static Map<String, dynamic>? _cachedTranslations;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Static initializer for translations
  static Future<void> initialize() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/translations/vi.json');
      _cachedTranslations = json.decode(jsonString);
    } catch (e) {
      _cachedTranslations = {};
    }
  }

  Future<bool> load() async {
    String jsonString = await rootBundle
        .loadString('assets/translations/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap;
    _cachedTranslations = jsonMap; // Update cached translations
    return true;
  }

  String translate(String key) {
    List<String> keys = key.split('.');
    dynamic value = _localizedStrings ?? _cachedTranslations;

    for (String k in keys) {
      if (value is Map && value.containsKey(k)) {
        value = value[k];
      } else {
        return key; // Return key if not found
      }
    }

    return value?.toString() ?? key;
  }

  // Static translate for global access
  static String translateStatic(String key) {
    List<String> keys = key.split('.');
    dynamic value = _cachedTranslations;

    for (String k in keys) {
      if (value is Map && value.containsKey(k)) {
        value = value[k];
      } else {
        return key;
      }
    }

    return value?.toString() ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'vi', 'id'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// Global helper function to replace easy_localization's tr()
String tr(String key, {BuildContext? context}) {
  if (context != null) {
    return AppLocalizations.of(context)?.translate(key) ?? 
           AppLocalizations.translateStatic(key);
  }
  return AppLocalizations.translateStatic(key);
}

// Extension for easy access
extension LocalizationExtension on BuildContext {
  String tr(String key) {
    return AppLocalizations.of(this)?.translate(key) ?? key;
  }

  AppLocalizations? get localizations => AppLocalizations.of(this);
}
