import '../../common/themoviedb_constants.dart';
import '../../models/service/movie/movies_response.dart';
import '../../services/themoviedb/themoviedb_service.dart';
import 'movies_repository.dart';

/// Implementation of MoviesRepository
/// Handles movie data operations
class MoviesRepositoryImpl implements MoviesRepository {
  final TheMovieDBService _theMovieDBService;

  MoviesRepositoryImpl(this._theMovieDBService);

  @override
  Future<MoviesResponse> getMoviesByCategory(
    MovieCategory category, {
    int page = 1,
    String language = 'en-US',
  }) {
    return _theMovieDBService.getMoviesByCategory(
      category,
      page: page,
      language: language,
    );
  }

  @override
  Future<MoviesResponse> getNowPlayingMovies({
    int page = 1,
    String language = 'en-US',
  }) {
    return _theMovieDBService.getNowPlayingMovies(
      page: page,
      language: language,
    );
  }

  @override
  Future<MoviesResponse> getPopularMovies({
    int page = 1,
    String language = 'en-US',
  }) {
    return _theMovieDBService.getPopularMovies(
      page: page,
      language: language,
    );
  }

  @override
  Future<MoviesResponse> getTopRatedMovies({
    int page = 1,
    String language = 'en-US',
  }) {
    return _theMovieDBService.getTopRatedMovies(
      page: page,
      language: language,
    );
  }

  @override
  Future<MoviesResponse> getUpcomingMovies({
    int page = 1,
    String language = 'en-US',
  }) {
    return _theMovieDBService.getUpcomingMovies(
      page: page,
      language: language,
    );
  }
}
