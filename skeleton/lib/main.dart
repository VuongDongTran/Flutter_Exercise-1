import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:skeleton/src/common/env_initializer.dart';

import 'src/base/utils/global_key.dart';
import 'src/common/app_config.dart';
import 'src/common/app_localizations.dart';
import 'src/routers/app_routes.dart';
import 'src/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent, // transparent status bar
    ),
  );
  await initializeEnvironment();
  await AppLocalizations.initialize();
  await AppConfig().initAppConfig();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (_) {
        return FlavorBanner(
          child: MaterialApp(
            navigatorKey: navigatorKey,
            initialRoute: AppRoutes.initialRoute,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('vi', 'VN'),
            ],
            locale: const Locale('vi', 'VN'),
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            theme: appLightTheme(context),
          ),
        );
      },
    );
  }
}
