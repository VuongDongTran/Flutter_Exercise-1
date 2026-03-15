import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// State for language selection
class LanguageState {
  final Locale locale;
  final String languageCode;

  const LanguageState({
    required this.locale,
    required this.languageCode,
  });

  factory LanguageState.initial(String languageCode) {
    return LanguageState(
      locale: Locale(languageCode),
      languageCode: languageCode,
    );
  }
}

/// Cubit for managing language/locale
class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(String initialLanguage)
      : super(LanguageState.initial(initialLanguage));

  /// Change the language
  void changeLanguage(String languageCode) {
    emit(LanguageState(
      locale: Locale(languageCode),
      languageCode: languageCode,
    ));
  }
}
