import '../../common/themoviedb_constants.dart';
import '../../models/service/movie/movies_response.dart';

/// Repository interface for movies data
abstract class MoviesRepository {
  /// Get movies by category
  Future<MoviesResponse> getMoviesByCategory(
    MovieCategory category, {
    int page = 1,
    String language = 'en-US',
  });

  /// Get now playing movies
  Future<MoviesResponse> getNowPlayingMovies({
    int page = 1,
    String language = 'en-US',
  });

  /// Get popular movies
  Future<MoviesResponse> getPopularMovies({
    int page = 1,
    String language = 'en-US',
  });

  /// Get top rated movies
  Future<MoviesResponse> getTopRatedMovies({
    int page = 1,
    String language = 'en-US',
  });

  /// Get upcoming movies
  Future<MoviesResponse> getUpcomingMovies({
    int page = 1,
    String language = 'en-US',
  });

  /// Search movies by query
  Future<MoviesResponse> searchMovies(
    String query, {
    int page = 1,
    String language = 'en-US',
  });
}
