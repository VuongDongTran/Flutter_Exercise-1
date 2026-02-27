// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as int,
      title: json['title'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      popularity: (json['popularity'] as num).toDouble(),
      voteCount: json['vote_count'] as int?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'] as String?,
      originalLanguage: json['original_language'] as String?,
      adult: json['adult'] as bool,
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'popularity': instance.popularity,
      'vote_count': instance.voteCount,
      'vote_average': instance.voteAverage,
      'release_date': instance.releaseDate,
      'original_language': instance.originalLanguage,
      'adult': instance.adult,
      'genre_ids': instance.genreIds,
    };
