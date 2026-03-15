import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeleton/src/widgets/category.dart';
import 'package:skeleton/src/widgets/language_selector.dart';
import '../bloc/movies/movies_cubit.dart';
import '../bloc/movies/movies_state.dart';
import '../common/app_localizations.dart';
import '../theme/colors_theme.dart';
import 'film_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
    required this.greeting,
    required this.moviesCubit,
    this.userInitial = 'U',
    this.userAvatarUrl,
    this.onSearchChanged,
    this.onSearchPressed,
    this.onProfilePressed,
  });

  final String greeting;
  final MoviesCubit moviesCubit;
  final String userInitial;
  final String? userAvatarUrl;
  final Function(String)? onSearchChanged;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onProfilePressed;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late TextEditingController _searchController;
  Category _selectedCategory = Category.movies;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearchChanged(String value) {
    widget.onSearchChanged?.call(value);
  }

  void _handleSearchPressed() {
    _handleSearchChanged(_searchController.text);
    widget.onSearchPressed?.call();
  }

  void _onCategorySelected(Category category) {
    setState(() {
      _selectedCategory = category;
    });

    // Navigate to content list page with selected category
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => ContentListPage(category: category),
    //   ),
    // );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color( 0xFF8000FF),
            Color(0xFF000000)
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // Greeting and Profile Avatar Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(
                widget.greeting,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  ),
                )
              ),
              const LanguageSelector(),
              const SizedBox(width: 12),
              _buildProfileAvatar(),
            ],
          ),
          const SizedBox(height: 20),
          // Search Bar
          Container(
            width: 400,
            height: 46,
            decoration: BoxDecoration(
              color: Color(0xFF36076B),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Color(0xFF36076B),
                width: 1,
              ),
            ),
            // padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _handleSearchChanged,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: context.tr('home.search_hint'),
                      hintStyle: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.only(left: 15),
                    ),
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _handleSearchPressed,
                  child: Icon(
                    Iconsax.search_normal,
                    color: AppColors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
             child: CategoryChips(
                categories: Category.values,
                selectedCategory: _selectedCategory,
                onCategorySelected: _onCategorySelected,
              ),
          ),
          const SizedBox(height: 24),
          // Now Playing Movies - Horizontal Scrollable List
          SizedBox(
            height: 250,
            child: BlocBuilder<MoviesCubit, MoviesState>(
              bloc: widget.moviesCubit,
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (movies, currentPage, totalPages, hasMorePages) {
                    if (movies.isEmpty) {
                      return Center(
                        child: Text(
                          context.tr('home.no_movies'),
                          style: TextStyle(color: AppColors.white),
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          movies.length + 1,
                          (index) {
                            if (index == movies.length) {
                              // Add spacing at the end
                              return const SizedBox(width: 16);
                            }
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 16 : 8,
                                right: 8,
                              ),
                              child: SizedBox(
                                width: 200,
                                height: 250,
                                child: FilmCard(
                                  movie: movies[index],
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Movie: ${movies[index].title}',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  loading: () {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) => Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? 16 : 8,
                              right: 8,
                            ),
                            child: _buildShimmerCard(200, 250),
                          ),
                        ),
                      ),
                    );
                  },
                  error: (message) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.emoji_sad,
                            size: 48,
                            color: AppColors.neutral30,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Error loading now playing',
                            style: TextStyle(
                              color: AppColors.neutral70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  orElse: () => Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          // Mais Populares Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.tr('home.most_popular'),
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Popular Movies - Horizontal Scrollable List
          SizedBox(
            height: 250,
            child: BlocBuilder<MoviesCubit, MoviesState>(
              bloc: widget.moviesCubit,
              builder: (context, state) {
                final popularMovies = state is MoviesLoaded ? state.movies : null;
                
                if (popularMovies == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (popularMovies.isEmpty) {
                  return Center(
                    child: Text(
                      context.tr('home.no_movies'),
                      style: TextStyle(color: AppColors.white),
                    ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      popularMovies.length + 1,
                      (index) {
                        if (index == popularMovies.length) {
                          // Add spacing at the end
                          return const SizedBox(width: 16);
                        }
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 16 : 8,
                            right: 8,
                          ),
                          child: SizedBox(
                            width: 200,
                            height: 250,
                            child: FilmCard(
                              movie: popularMovies[index],
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Movie: ${popularMovies[index].title}',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 100),

        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return GestureDetector(
      onTap: widget.onProfilePressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 200),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Gradient Border
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.ceriseColor,
                      AppColors.purple,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.deepPurple,
                  ),
                  child: ClipOval(
                    child: widget.userAvatarUrl != null
                        ? Image.network(
                            widget.userAvatarUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildInitialAvatar();
                            },
                          )
                        : _buildInitialAvatar(),
                  ),
                ),
              ),
              // Notification Badge
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.ceriseColor,
                    border: Border.all(color: AppColors.deepPurple, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialAvatar() {
    return Container(
      color: AppColors.purple,
      child: Center(
        child: Text(
          widget.userInitial.toUpperCase(),
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  Widget _buildShimmerCard(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.neutral10,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
