import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/app_localizations.dart';
import '../../../theme/colors_theme.dart';

class NavigationBarItem {
  NavigationBarItem({required this.bottomNavigationBarItem});
  final BottomNavigationBarItem bottomNavigationBarItem;
}

List<NavigationBarItem> navigation = [
  NavigationBarItem(
    bottomNavigationBarItem: BottomNavigationBarItem(
        backgroundColor: AppColors.background100,
        label: tr('movies.title'),
        activeIcon: const Icon(
          Iconsax.video,
          color: AppColors.ceriseColor,
          size: 28.0,
        ),
        icon: Icon(
          Iconsax.video,
          color: AppColors.neutral90,
          size: 28.0,
        )),
  ),
  NavigationBarItem(
    bottomNavigationBarItem: BottomNavigationBarItem(
        backgroundColor: AppColors.background100,
        label: tr('tv_shows.title'),
        activeIcon: const Icon(
          Iconsax.monitor,
          color: AppColors.ceriseColor,
          size: 28.0,
        ),
        icon: Icon(
          Iconsax.monitor,
          color: AppColors.neutral90,
          size: 28.0,
        )),
  ),
];

List<BottomNavigationBarItem> menuDefault = [
  BottomNavigationBarItem(
      backgroundColor: AppColors.background100,
      label: tr('movies.title'),
      activeIcon: const Icon(
        Iconsax.video,
        color: AppColors.ceriseColor,
        size: 28.0,
      ),
      icon: Icon(
        Iconsax.video,
        color: AppColors.neutral90,
        size: 28.0,
      )),
  BottomNavigationBarItem(
      backgroundColor: AppColors.background100,
      label: tr('tv_shows.title'),
      activeIcon: const Icon(
        Iconsax.monitor,
        color: AppColors.ceriseColor,
        size: 28.0,
      ),
      icon: Icon(
        Iconsax.monitor,
        color: AppColors.neutral90,
        size: 28.0,
      )),
];
