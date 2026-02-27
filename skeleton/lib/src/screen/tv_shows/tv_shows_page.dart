import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../common/app_localizations.dart';
import '../../theme/colors_theme.dart';

class TVShowsPage extends StatefulWidget {
  const TVShowsPage({super.key});

  @override
  State<TVShowsPage> createState() => _TVShowsPageState();
}

class _TVShowsPageState extends State<TVShowsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('tv_shows.title')),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.search_normal),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Categories tabs
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryChip(tr('tv_shows.airing_today'), true),
                  const SizedBox(width: 8),
                  _buildCategoryChip(tr('tv_shows.on_the_air'), false),
                  const SizedBox(width: 8),
                  _buildCategoryChip(tr('tv_shows.popular'), false),
                  const SizedBox(width: 8),
                  _buildCategoryChip(tr('tv_shows.top_rated'), false),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // TV Shows grid
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.monitor,
                      size: 64,
                      color: AppColors.neutral30,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tr('tv_shows.coming_soon'),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tr('tv_shows.connect_api'),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.neutral50,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // TODO: Handle category selection
      },
      selectedColor: AppColors.ceriseColor,
      backgroundColor: AppColors.neutral10,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.neutral70,
      ),
    );
  }
}
