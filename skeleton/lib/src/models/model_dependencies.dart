import 'package:get_it/get_it.dart';

import 'view/movie/movie_mapper.dart';

class ModelDependencies {
  static void init(GetIt injector) {
    // Register mappers for DI
    injector.registerSingleton<MovieMapper>(MovieMapper());
  }
}
