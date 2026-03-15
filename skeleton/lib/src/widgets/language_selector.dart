import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/language/language_cubit.dart';
import '../common/app_localizations.dart';
import '../services/language/language_service.dart';
import '../theme/colors_theme.dart';
import '../app_dependency.dart';

/// Language selector dropdown widget
class LanguageSelector extends StatelessWidget {
  final VoidCallback? onLanguageChanged;

  const LanguageSelector({
    super.key,
    this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final langPref = AppDependencies.injector.get<LanguageService>();
    final languages = langPref.getSupportedLanguages();

    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return PopupMenuButton<String>(
          initialValue: state.languageCode,
          onSelected: (String languageCode) {
            // Save preference
            langPref.setLanguage(languageCode);
            // Update locale
            context.read<LanguageCubit>().changeLanguage(languageCode);
            // Update cached translation
            AppLocalizations(Locale(languageCode)).load();
            onLanguageChanged?.call();
          },
          itemBuilder: (BuildContext context) {
            return languages.map((String languageCode) {
              return PopupMenuItem<String>(
                value: languageCode,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Language flag icons
                    Text(
                      _getLanguageFlag(languageCode),
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      langPref.getLanguageName(languageCode),
                      style: TextStyle(
                        color: state.languageCode == languageCode
                            ? AppColors.ceriseColor
                            : Colors.black,
                        fontWeight: state.languageCode == languageCode
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.neutral10,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _getLanguageFlag(state.languageCode),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, size: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Get emoji flag for language code
  String _getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇬🇧'; // UK flag
      case 'es':
        return '🇪🇸'; // Spain flag
      case 'vi':
        return '🇻🇳'; // Vietnam flag
      case 'id':
        return '🇮🇩'; // Indonesia flag
      default:
        return '🌐';
    }
  }
}
