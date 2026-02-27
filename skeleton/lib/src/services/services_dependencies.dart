import 'package:get_it/get_it.dart';

import '../base/restful/rest_utility.dart';
import '../common/constants.dart';
import 'auth/auth_service.dart';
import 'general/general_service.dart';
import 'themoviedb/themoviedb_service.dart';

class ServicesDependencies {
  static void init(GetIt injector) {
    injector.registerFactory<Authentication>(() => AuthService(
        injector.get<RestUtils>(instanceName: InstanceResflul.instanceAuth)));
    injector.registerFactory<GeneralService>(() => GeneralServiceImpl(
        injector.get<RestUtils>(instanceName: InstanceResflul.instanceApp)));
    injector.registerSingleton<TheMovieDBService>(
      TheMovieDBServiceImpl(
        injector.get<RestUtils>(instanceName: InstanceResflul.instanceApp),
      ),
    );
  }
}


