import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../app_dependency.dart';
import '../bloc/movies/movies_cubit.dart';
import '../bloc/movies/movies_state.dart';
import '../common/app_localizations.dart';
import '../preferences/user_preference.dart';
import '../theme/colors_theme.dart';
import '../widgets/category.dart';
import '../widgets/film_card.dart';
import '../widgets/home_page.dart';

/// Home page displaying greeting, categories, and popular content
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MoviesCubit _moviesCubit;
  Category _selectedCategory = Category.movies;
  String _userName = 'User';
  String _searchKey = '';

  @override
  void initState() {
    super.initState();
    _moviesCubit = AppDependencies.injector.get<MoviesCubit>();
    _loadUserName();
    _loadInitialContent();
  }

  Future<void> _loadUserName() async {
    try {
      final userPref = AppDependencies.injector.get<UserPreference>();
      final username = await userPref.getValue('USERNAME') ?? 'User';
      setState(() {
        _userName = username;
      });
    } catch (e) {
      // Ignore - use default
    }
  }

  void _loadInitialContent() {
    _moviesCubit.getMovies();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchKey = query;
    });
  }

  String _getUserInitial() {
    return _userName.isNotEmpty ? _userName[0].toUpperCase() : 'U';
  }

  void _onCategorySelected(Category category) {
    setState(() {
      _selectedCategory = category;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GestureDetector(
        onHorizontalDragUpdate: (details) => _handleBack(details, context),
        child: CustomScrollView(
          slivers: [
            // Greeting Header
            SliverToBoxAdapter(
              child: Homepage(
                greeting: context.tr('home.greeting'),
                moviesCubit: _moviesCubit,
                userInitial: _getUserInitial(),
                onSearchChanged: _onSearchChanged,
                onSearchPressed: () {
                  _moviesCubit.loadPopularMovies(searchKey: _searchKey);
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral10,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void _handleBack(DragUpdateDetails details, BuildContext context) {
    int sensitivity = 8;
    if (details.delta.dx > sensitivity) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }
}