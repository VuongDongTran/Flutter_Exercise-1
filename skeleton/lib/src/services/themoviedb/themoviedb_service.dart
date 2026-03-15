import 'dart:convert';

import '../../base/services/base_service.dart';
import '../../common/themoviedb_constants.dart';
import '../../models/service/movie/movies_response.dart';

/// Abstract interface for TheMovieDB API calls
abstract class TheMovieDBService extends BaseService {
  TheMovieDBService(super.restUtils);

  /// Get movies by category (now playing, popular, top rated, upcoming)
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

/// Implementation of TheMovieDB service
class TheMovieDBServiceImpl extends TheMovieDBService {
  TheMovieDBServiceImpl(super.restUtils);

  @override
  Future<MoviesResponse> getMoviesByCategory(
    MovieCategory category, {
    int page = 1,
    String language = 'en-US',
  }) async {
    try {
      final response = await rest.dio.get<String>(
        category.endpoint,
        queryParameters: {
          TheMovieDBConstants.paramApiKey: TheMovieDBConstants.apiKey,
          TheMovieDBConstants.paramPage: page,
          'language': language,
        },
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> jsonData = 
            json.decode(response.data!) as Map<String, dynamic>;
        return MoviesResponse.fromJson(jsonData);
      }
      throw Exception('Failed to load movies');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MoviesResponse> getNowPlayingMovies({
    int page = 1,
    String language = 'en-US',
  }) {
    return getMoviesByCategory(
      MovieCategory.nowPlaying,
      page: page,
      language: language,
    );
  }

  @override
  Future<MoviesResponse> getPopularMovies({
    int page = 1,
    String language = 'en-US',
  }) {
    return getMoviesByCategory(
      MovieCategory.popular,
      page: page,
      language: language,
    );
  }

  @override
  Future<MoviesResponse> getTopRatedMovies({
    int page = 1,
    String language = 'en-US',
  }) {
    return getMoviesByCategory(
      MovieCategory.topRated,
      page: page,
      language: language,
    );
  }

  @override
  Future<MoviesResponse> getUpcomingMovies({
    int page = 1,
    String language = 'en-US',
  }) {
    return getMoviesByCategory(
      MovieCategory.upcoming,
      page: page,
      language: language,
    );
  }

  @override
  Future<MoviesResponse> searchMovies(
    String query, {
    int page = 1,
    String language = 'en-US',
  }) async {
    try {
      final response = await rest.dio.get<String>(
        TheMovieDBConstants.movieSearch,
        queryParameters: {
          TheMovieDBConstants.paramApiKey: TheMovieDBConstants.apiKey,
          'query': query,
          TheMovieDBConstants.paramPage: page,
          'language': language,
        },
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> jsonData = 
            json.decode(response.data!) as Map<String, dynamic>;
        return MoviesResponse.fromJson(jsonData);
      }
      throw Exception('Failed to search movies');
    } catch (e) {
      rethrow;
    }
  }
}

