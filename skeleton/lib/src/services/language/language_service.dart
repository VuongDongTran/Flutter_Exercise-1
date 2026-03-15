import 'package:shared_preferences/shared_preferences.dart';

/// Service to manage language preferences
class LanguageService {
  static const _languageKey = 'selected_language';
  final SharedPreferences _prefs;

  LanguageService(this._prefs);

  /// Get the saved language code (default: 'vi')
  String getLanguage() {
    return _prefs.getString(_languageKey) ?? 'vi';
  }

  /// Save the selected language code
  Future<bool> setLanguage(String languageCode) async {
    return _prefs.setString(_languageKey, languageCode);
  }

  /// Get all supported languages
  List<String> getSupportedLanguages() {
    return ['en', 'es', 'vi', 'id'];
  }

  /// Get language name for UI display
  String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'vi':
        return 'Tiếng Việt';
      case 'id':
        return 'Bahasa Indonesia';
      default:
        return languageCode;
    }
  }
}
