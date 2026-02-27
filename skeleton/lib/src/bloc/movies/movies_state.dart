import '../../models/view/movie/movie_view_model.dart';

/// Movies state
abstract class MoviesState {
  const MoviesState();
}

class MoviesInitial extends MoviesState {
  const MoviesInitial();
}

class MoviesLoading extends MoviesState {
  const MoviesLoading();
}

class MoviesLoaded extends MoviesState {
  final List<MovieViewModel> movies;
  final int currentPage;
  final int totalPages;
  final bool hasMorePages;

  const MoviesLoaded({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
    required this.hasMorePages,
  });
}

class MoviesPaginationLoading extends MoviesState {
  final List<MovieViewModel> previousMovies;
  final int currentPage;

  const MoviesPaginationLoading({
    required this.previousMovies,
    required this.currentPage,
  });
}

class MoviesError extends MoviesState {
  final String message;

  const MoviesError({this.message = ''});
}

extension MoviesStateX on MoviesState {
  T maybeWhen<T>({
    T Function()? loading,
    T Function(List<MovieViewModel> movies, int currentPage, int totalPages, bool hasMorePages)? loaded,
    T Function(List<MovieViewModel> previousMovies, int currentPage)? paginationLoading,
    T Function(String message)? error,
    required T Function() orElse,
  }) {
    if (this is MoviesLoading) {
      return loading?.call() ?? orElse();
    } else if (this is MoviesLoaded) {
      final state = this as MoviesLoaded;
      return loaded?.call(state.movies, state.currentPage, state.totalPages, state.hasMorePages) ?? orElse();
    } else if (this is MoviesPaginationLoading) {
      final state = this as MoviesPaginationLoading;
      return paginationLoading?.call(state.previousMovies, state.currentPage) ?? orElse();
    } else if (this is MoviesError) {
      final state = this as MoviesError;
      return error?.call(state.message) ?? orElse();
    }
    return orElse();
  }
}

