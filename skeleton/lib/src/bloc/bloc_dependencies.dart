import 'package:get_it/get_it.dart';

import '../repositories/auth/auth_repository.dart';
import '../repositories/movies/movies_repository.dart';
import 'auth/login_cubit.dart';
import 'loading/loading_cubit.dart';
import 'menu/menu_cubit.dart';
import 'movies/movies_cubit.dart';

/// Dependency injection setup for all BLoCs
/// Called in app initialization to register BLoC dependencies
class BlocDependencies {
  static void init(GetIt injector) {
    // Login BLoC - uses AuthRepository (which depends on AuthService)
    injector.registerFactory<LoginCubit>(
      () => LoginCubit(
        injector<AuthRepository>(),
        injector(),
      ),
    );

    // Movies BLoC - uses MoviesRepository (which depends on TheMovieDBService)
    injector.registerFactory<MoviesCubit>(
      () => MoviesCubit(
        injector<MoviesRepository>(),
      ),
    );

    injector.registerFactory<LoadingCubit>(() => LoadingCubit());
    injector.registerLazySingleton<MenuCubit>(() => MenuCubit());
  }
}

