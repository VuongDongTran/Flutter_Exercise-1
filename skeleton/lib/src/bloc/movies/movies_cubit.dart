import 'dart:developer' as developer;

import '../../base/bloc/base_cubit.dart';
import '../../common/themoviedb_constants.dart';
import '../../models/view/movie/movie_mapper.dart';
import '../../repositories/movies/movies_repository.dart';
import 'movies_state.dart';

/// BLoC for managing movies data and state
class MoviesCubit extends BaseCubit<MoviesState> {
  MoviesCubit(this._moviesRepository) : super(const MoviesInitial());

  final MoviesRepository _moviesRepository;
  final _movieMapper = MovieMapper();

  // Current category
  MovieCategory _currentCategory = MovieCategory.nowPlaying;
  MovieCategory get currentCategory => _currentCategory;

  // Search query state
  String _currentSearchKey = '';
  String get currentSearchKey => _currentSearchKey;

  /// Load movies by category
  Future<void> loadMoviesByCategory(MovieCategory category, {String searchKey = ''}) async {
    try {
      _currentCategory = category;
      _currentSearchKey = searchKey;
      loadingSink.add(true);
      emit(const MoviesLoading());

      final result = await _moviesRepository.getMoviesByCategory(
        category,
        page: 1,
      );

      var viewModels = result.results?.map(_movieMapper.call).toList() ?? [];
      
      // Filter by search key if provided
      if (searchKey.isNotEmpty) {
        viewModels = viewModels
            .where((movie) =>
                movie.title?.toLowerCase().contains(searchKey.toLowerCase()) ?? false)
            .toList();
      }
      
      emit(MoviesLoaded(
        movies: viewModels,
        currentPage: result.page ?? 1,
        totalPages: result.totalPages ?? 0,
        hasMorePages: (result.page ?? 1) < (result.totalPages ?? 0),
      ));
    } catch (e, stackTrace) {
      developer.log(
        'Load movies error',
        error: e,
        stackTrace: stackTrace,
      );
      emit(MoviesError(message: _getErrorMessage(e)));
      errorSink.add(_getErrorMessage(e));
    } finally {
      loadingSink.add(false);
    }
  }

  /// Load more movies (pagination)
  Future<void> loadMoreMovies() async {
    final state = this.state;
    if (state is! MoviesLoaded || !state.hasMorePages) return;

    try {
      emit(MoviesPaginationLoading(
        previousMovies: state.movies,
        currentPage: state.currentPage,
      ));

      final result = await _moviesRepository.getMoviesByCategory(
        _currentCategory,
        page: state.currentPage + 1,
      );

      final newViewModels = result.results?.map(_movieMapper.call).toList() ?? [];
      final newMovies = [...state.movies, ...newViewModels];
      emit(MoviesLoaded(
        movies: newMovies,
        currentPage: result.page ?? state.currentPage,
        totalPages: result.totalPages ?? state.totalPages,
        hasMorePages: (result.page ?? state.currentPage) < (result.totalPages ?? state.totalPages),
      ));
    } catch (e, stackTrace) {
      developer.log(
        'Load more movies error',
        error: e,
        stackTrace: stackTrace,
      );
      // Keep the previous state and show error
      emit(state);
      errorSink.add(_getErrorMessage(e));
    }
  }

  /// Load now playing movies
  Future<void> loadNowPlayingMovies({String searchKey = ''}) async {
    await loadMoviesByCategory(MovieCategory.nowPlaying, searchKey: searchKey);
  }

  /// Load popular movies
  Future<void> loadPopularMovies({String searchKey = ''}) async {
    await loadMoviesByCategory(MovieCategory.popular, searchKey: searchKey);
  }

  /// Load top rated movies
  Future<void> loadTopRatedMovies({String searchKey = ''}) async {
    await loadMoviesByCategory(MovieCategory.topRated, searchKey: searchKey);
  }

  /// Load upcoming movies
  Future<void> loadUpcomingMovies({String searchKey = ''}) async {
    await loadMoviesByCategory(MovieCategory.upcoming, searchKey: searchKey);
  }

  /// Search movies by keyword 
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _currentSearchKey = '';
      // Return to category view
      await loadMoviesByCategory(_currentCategory);
      return;
    }

    try {
      _currentSearchKey = query;
      loadingSink.add(true);
      emit(const MoviesLoading());

      final result = await _moviesRepository.searchMovies(
        query,
        page: 1,
      );

      final viewModels = result.results?.map(_movieMapper.call).toList() ?? [];
      emit(MoviesLoaded(
        movies: viewModels,
        currentPage: result.page ?? 1,
        totalPages: result.totalPages ?? 0,
        hasMorePages: (result.page ?? 1) < (result.totalPages ?? 0),
      ));
    } catch (e, stackTrace) {
      developer.log(
        'Search movies error',
        error: e,
        stackTrace: stackTrace,
      );
      emit(MoviesError(message: _getErrorMessage(e)));
      errorSink.add(_getErrorMessage(e));
    } finally {
      loadingSink.add(false);
    }
  }

  /// Search movies by query within a specific category
  Future<void> searchMoviesByCategory(String query, MovieCategory category) async {
    if (query.isEmpty) {
      _currentSearchKey = '';
      await loadMoviesByCategory(category);
      return;
    }

    try {
      _currentSearchKey = query;
      _currentCategory = category;
      loadingSink.add(true);
      emit(const MoviesLoading());

      // Fetch movies by category
      final result = await _moviesRepository.getMoviesByCategory(
        category,
        page: 1,
      );

      // Filter locally by title matching the query
      final allMovies = result.results ?? [];
      final filteredMovies = allMovies
          .where((movie) =>
              movie.title?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();

      final viewModels = filteredMovies.map(_movieMapper.call).toList();
      emit(MoviesLoaded(
        movies: viewModels,
        currentPage: 1,
        totalPages: 1,
        hasMorePages: false,
      ));
    } catch (e, stackTrace) {
      developer.log(
        'Search movies by category error',
        error: e,
        stackTrace: stackTrace,
      );
      emit(MoviesError(message: _getErrorMessage(e)));
      errorSink.add(_getErrorMessage(e));
    } finally {
      loadingSink.add(false);
    }
  }

  /// Clear search and return to category view
  Future<void> clearSearch() async {
    _currentSearchKey = '';
    await loadMoviesByCategory(_currentCategory);
  }

  Future<void> getMovies() async {
    try {
      loadingSink.add(true);
      emit(const MoviesLoading());

      // Load both lists in parallel
      final nowPlayingFuture = _moviesRepository.getMoviesByCategory(
        MovieCategory.nowPlaying,
        page: 1,
      );
      final popularFuture = _moviesRepository.getMoviesByCategory(
        MovieCategory.popular,
        page: 1,
      );

      final results = await Future.wait([nowPlayingFuture, popularFuture]);
      final nowPlayingResult = results[0];
      final popularResult = results[1];

      final nowPlayingViewModels =
          nowPlayingResult.results?.map(_movieMapper.call).toList() ?? [];
      final popularViewModels =
          popularResult.results?.map(_movieMapper.call).toList() ?? [];

      _currentCategory = MovieCategory.nowPlaying;
      
      emit(MoviesLoaded(
        movies: nowPlayingViewModels,
        currentPage: nowPlayingResult.page ?? 1,
        totalPages: nowPlayingResult.totalPages ?? 0,
        hasMorePages: (nowPlayingResult.page ?? 1) <
            (nowPlayingResult.totalPages ?? 0),  ));
    } catch (e, stackTrace) {
      developer.log(
        'Load now playing and popular movies error',
        error: e,
        stackTrace: stackTrace,
      );
      emit(MoviesError(message: _getErrorMessage(e)));
      errorSink.add(_getErrorMessage(e));
    } finally {
      loadingSink.add(false);
    }
  }

  /// Parse exception to user-friendly error message
  String _getErrorMessage(dynamic exception) {
    if (exception is Exception) {
      return exception.toString();
    }
    return 'An unexpected error occurred loading movies';
  }
}

