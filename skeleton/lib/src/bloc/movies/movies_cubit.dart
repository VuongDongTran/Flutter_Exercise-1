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

  /// Load movies by category
  Future<void> loadMoviesByCategory(MovieCategory category) async {
    try {
      _currentCategory = category;
      loadingSink.add(true);
      emit(const MoviesLoading());

      final result = await _moviesRepository.getMoviesByCategory(
        category,
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
  Future<void> loadNowPlayingMovies() async {
    await loadMoviesByCategory(MovieCategory.nowPlaying);
  }

  /// Load popular movies
  Future<void> loadPopularMovies() async {
    await loadMoviesByCategory(MovieCategory.popular);
  }

  /// Load top rated movies
  Future<void> loadTopRatedMovies() async {
    await loadMoviesByCategory(MovieCategory.topRated);
  }

  /// Load upcoming movies
  Future<void> loadUpcomingMovies() async {
    await loadMoviesByCategory(MovieCategory.upcoming);
  }

  /// Parse exception to user-friendly error message
  String _getErrorMessage(dynamic exception) {
    if (exception is Exception) {
      return exception.toString();
    }
    return 'An unexpected error occurred loading movies';
  }
}

