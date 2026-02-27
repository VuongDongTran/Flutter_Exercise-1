import 'package:get_it/get_it.dart';

import '../services/auth/auth_service.dart';
import '../services/themoviedb/themoviedb_service.dart';
import 'auth/auth_repository.dart';
import 'auth/auth_repository_impl.dart';
import 'movies/movies_repository.dart';
import 'movies/movies_repository_impl.dart';

/// Dependency injection setup for all repositories
/// Repositories depend on services and preferences
class RepositoriesDependencies {
  static void init(GetIt injector) {
    // Auth Repository
    injector.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(
        injector<Authentication>(),
        injector(),
      ),
    );

    // Movies Repository
    injector.registerSingleton<MoviesRepository>(
      MoviesRepositoryImpl(
        injector<TheMovieDBService>(),
      ),
    );
  }
}


