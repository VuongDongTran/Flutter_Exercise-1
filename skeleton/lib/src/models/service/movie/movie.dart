import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

/// Movie model from TheMovieDB API
@JsonSerializable()
class Movie {
  final int id;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double popularity;
  final int? voteCount;
  final double voteAverage;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  final bool adult;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  Movie({
    required this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.backdropPath,
    required this.popularity,
    this.voteCount,
    required this.voteAverage,
    this.releaseDate,
    this.originalLanguage,
    required this.adult,
    this.genreIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  /// Get poster URL
  String? getPosterUrl({String size = 'w500'}) {
    return posterPath != null
        ? 'https://image.tmdb.org/t/p/$size$posterPath'
        : null;
  }

  /// Get backdrop URL
  String? getBackdropUrl({String size = 'w1280'}) {
    return backdropPath != null
        ? 'https://image.tmdb.org/t/p/$size$backdropPath'
        : null;
  }

  @override
  String toString() => 'Movie(id: $id, title: $title, voteAverage: $voteAverage)';
}
