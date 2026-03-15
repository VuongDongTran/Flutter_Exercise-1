/// TheMovieDB API Constants
/// API Documentation: https://developer.themoviedb.org/docs/getting-started
abstract class TheMovieDBConstants {
  // API Configuration
  static const String apiBaseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';
  
  // API Key
  static const String apiKey = '996a247a34da0a64a095c8f785896a6d'; // Replace with your actual API key

  // API Endpoints
  static const String movieNowPlaying = '/movie/now_playing';
  static const String moviePopular = '/movie/popular';
  static const String movieTopRated = '/movie/top_rated';
  static const String movieUpcoming = '/movie/upcoming';
  static const String movieDetails = '/movie';
  static const String movieSearch = '/search/movie';

  // Query Parameters
  static const String paramApiKey = 'api_key';
  static const String paramPage = 'page';
  static const String paramLanguage = 'language';
  static const String paramRegion = 'region';

  // Image Sizes
  static const String imageSizeSmall = 'w342';
  static const String imageSizeMedium = 'w500';
  static const String imageSizeLarge = 'w780';
  static const String imageSizeXLarge = 'w1280';
}

/// Movie category enum for different types
enum MovieCategory {
  nowPlaying('movies.now_playing', TheMovieDBConstants.movieNowPlaying),
  popular('movies.popular', TheMovieDBConstants.moviePopular),
  topRated('movies.top_rated', TheMovieDBConstants.movieTopRated),
  upcoming('movies.upcoming', TheMovieDBConstants.movieUpcoming);

  final String localizationKey;
  final String endpoint;

  const MovieCategory(this.localizationKey, this.endpoint);
}
