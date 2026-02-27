import '../../../base/mapping/base_mapping.dart';
import '../../service/movie/movie.dart';
import 'movie_view_model.dart';

/// Mapper from Movie (service model) to MovieViewModel (view model)
class MovieMapper extends Mapper<Movie, MovieViewModel> {
  @override
  MovieViewModel call(Movie movie) {
    return MovieViewModel(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      voteAverage: movie.voteAverage,
    );
  }
}
