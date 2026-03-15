import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/interceptor/auth_interceptor.dart';
import 'base/restful/interceptors.dart';
import 'base/restful/rest_utility.dart';
import 'bloc/bloc_dependencies.dart';
import 'bloc/language/language_cubit.dart';
import 'business/business_dependencies.dart';
import 'common/app_config.dart';
import 'common/constants.dart';
import 'common/logger_helper.dart';
import 'models/model_dependencies.dart';
import 'preferences/user_preference.dart';
import 'repositories/repositories_dependencies.dart';
import 'services/language/language_service.dart';
import 'services/services_dependencies.dart';

class AppDependencies {
  static GetIt injector = GetIt.instance;

  static Future<bool> initialize() async {
    try {
      injector.registerLazySingleton<AppConfig>(() => AppConfig());
      injector.registerLazySingleton<Connectivity>(() => Connectivity());
      injector.registerFactory<UserPreference>(() => ImplUserPreference());
      
      // Initialize SharedPreferences for language preference
      final prefs = await SharedPreferences.getInstance();
      injector.registerLazySingleton<LanguageService>(
          () => LanguageService(prefs));
      
      final langPref = injector.get<LanguageService>();
      injector.registerLazySingleton<LanguageCubit>(
          () => LanguageCubit(langPref.getLanguage()));
      
      final config = injector.get<AppConfig>();
      await config.loadAppConfig();
      injector.registerLazySingleton<RestUtils>(
          () => RestUtils(config.baseUrl, interceptors: [
                LoggingInterceptor(),
              ]),
          instanceName: InstanceResflul.instanceAuth);
      injector.registerLazySingleton<RestUtils>(
          () => RestUtils(config.baseUrl, interceptors: [
                LoggingInterceptor(),
                TokenInterceptor(),
                AuthInterceptor()
              ]),
          instanceName: InstanceResflul.instanceApp);
      ModelDependencies.init(injector);
      ServicesDependencies.init(injector);
      RepositoriesDependencies.init(injector);
      BusinessesDependencies.init(injector);
      BlocDependencies.init(injector);
    } catch (ex) {
      LoggerHelper.d(ex.toString());
    }
    return true;
  }
}
