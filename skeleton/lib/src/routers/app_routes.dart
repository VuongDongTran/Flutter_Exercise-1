import 'package:flutter/material.dart';
import '../screen/auth/login_page.dart';
import '../screen/home_page.dart';
import '../screen/loading_page.dart';
import 'route_key.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
        RouteKey.loading: (context) => const LoadingPage(),
        RouteKey.login: (context) => const LoginPage(),
        RouteKey.home: (context) => const HomePage(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final routes = AppRoutes.routes;
    final builder = routes[settings.name];
    
    if (builder != null) {
      return MaterialPageRoute(
        builder: builder,
        settings: settings,
      );
    }
    
    return null;
  }

  static String get initialRoute => RouteKey.loading;
}
