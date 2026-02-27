/// Movie ViewModel for UI display
/// Contains only fields needed for presentation layer
class MovieViewModel {
  final int id;
  final String? title;
  final String? posterPath;
  final double voteAverage;

  const MovieViewModel({
    required this.id,
    this.title,
    this.posterPath,
    required this.voteAverage,
  });

  /// Get poster URL
  String? getPosterUrl({String size = 'w342'}) {
    return posterPath != null
        ? 'https://image.tmdb.org/t/p/$size$posterPath'
        : null;
  }

  @override
  String toString() =>
      'MovieViewModel(id: $id, title: $title, voteAverage: $voteAverage)';
}
