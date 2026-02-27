import 'package:json_annotation/json_annotation.dart';
import 'movie.dart';

part 'movies_response.g.dart';

/// Paginated movies response from TheMovieDB API
@JsonSerializable()
class MoviesResponse {
  final int? page;
  final List<Movie>? results;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'total_results')
  final int? totalResults;

  MoviesResponse({
     this.page,
     this.results,
     this.totalPages,
     this.totalResults,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MoviesResponseToJson(this);

  @override
  String toString() =>
      'MoviesResponse(page: $page, results: ${results?.length}, totalPages: $totalPages)';
}
