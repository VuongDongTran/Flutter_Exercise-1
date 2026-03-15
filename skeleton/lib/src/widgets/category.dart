import 'package:flutter/material.dart';
import '../common/app_localizations.dart';
import '../theme/colors_theme.dart';

// Enum for different content categories when navigating
enum Category {
  movies,
  tvShows,
  animes,
  novels;

  /// Get the translation key for this category
  String getTranslationKey() {
    switch (this) {
      case Category.movies:
        return 'categories.films';
      case Category.tvShows:
        return 'categories.series';
      case Category.animes:
        return 'categories.animes';
      case Category.novels:
        return 'categories.novels';
    }
  }

  /// Get the display name with translation from context
  String getLocalizedName(BuildContext context) {
    return context.tr(getTranslationKey());
  }
}

class CategoryChips extends StatelessWidget {
  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<Category> categories;
  final Category selectedCategory;
  final Function(Category) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: List.generate(
          categories.length,
          (index) {
            final category = categories[index];
            final isSelected = category == selectedCategory;
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () => onCategorySelected(category),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: Text(
                    category.getLocalizedName(context),
                    style: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.neutral70,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
