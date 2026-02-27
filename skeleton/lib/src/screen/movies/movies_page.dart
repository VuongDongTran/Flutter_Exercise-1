import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/movies/movies_cubit.dart';
import '../../common/app_localizations.dart';
import '../../bloc/movies/movies_state.dart';
import '../../common/themoviedb_constants.dart';
import '../../models/view/movie/movie_view_model.dart';
import '../../theme/colors_theme.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Load initial movies
    context.read<MoviesCubit>().loadNowPlayingMovies();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Load more movies when scrolled to bottom
      context.read<MoviesCubit>().loadMoreMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('movies.title')),
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
      body: Column(
        children: [
          // Categories tabs
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: MovieCategory.values
                  .asMap()
                  .entries
                  .expand((entry) => [
                        _buildCategoryChip(entry.value, entry.key == 0),
                        if (entry.key < MovieCategory.values.length - 1)
                          const SizedBox(width: 8),
                      ])
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          // Movies grid
          Expanded(
            child: BlocBuilder<MoviesCubit, MoviesState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => _buildLoadingShimmer(),
                  loaded: (movies, currentPage, totalPages, hasMorePages) {
                    return _buildMoviesGrid(movies, isLoadingMore: false);
                  },
                  paginationLoading: (previousMovies, currentPage) {
                    return _buildMoviesGrid(previousMovies, isLoadingMore: true);
                  },
                  error: (message) => _buildErrorWidget(message),
                  orElse: () => _buildEmptyWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(MovieCategory category, bool isSelected) {
    return FilterChip(
      label: Text(tr(category.localizationKey)),
      selected: isSelected,
      onSelected: (selected) {
        context.read<MoviesCubit>().loadMoviesByCategory(category);
      },
      selectedColor: AppColors.ceriseColor,
      backgroundColor: AppColors.neutral10,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.neutral70,
      ),
    );
  }

  Widget _buildMoviesGrid(List<MovieViewModel> movies, {bool isLoadingMore = false}) {
    return Stack(
      children: [
        GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _buildMovieCard(movie);
          },
        ),
        // Loading indicator for pagination
        if (isLoadingMore)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.ceriseColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMovieCard(MovieViewModel movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: movie.posterPath != null
                ? CachedNetworkImage(
                    imageUrl: movie.getPosterUrl(size: 'w342')!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.neutral10,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.neutral10,
                      child: const Icon(Iconsax.image),
                    ),
                  )
                : Container(
                    color: AppColors.neutral10,
                    child: const Icon(Iconsax.image),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        // Title
        Text(
          movie.title ?? tr('movies.unknown'),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 4),
        // Rating
        Row(
          children: [
            const Icon(
              Iconsax.star1,
              size: 14,
              color: AppColors.ceriseColor,
            ),
            const SizedBox(width: 4),
            Text(
              '${movie.voteAverage.toStringAsFixed(1)}/10',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.neutral50,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadingShimmer() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.neutral10,
          highlightColor: AppColors.neutral5,
          period: const Duration(milliseconds: 1500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.neutral10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 12,
                color: AppColors.neutral10,
              ),
              const SizedBox(height: 4),
              Container(
                height: 10,
                width: 50,
                color: AppColors.neutral10,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Iconsax.danger,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            tr('movies.error_loading'),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.neutral50,
                ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<MoviesCubit>().loadNowPlayingMovies();
            },
            child: Text(tr('movies.retry')),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.video,
            size: 64,
            color: AppColors.neutral30,
          ),
          const SizedBox(height: 16),
          Text(
            tr('movies.no_movies_found'),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
