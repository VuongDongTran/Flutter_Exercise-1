import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:global_configs/global_configs.dart';

import '../app_dependency.dart';
import 'constants.dart';

class AppConfig {
  String environment = const String.fromEnvironment('ENV');
  Future<void> initAppConfig() async {
    _configShowLoading();
    configBannerEnv();
    await AppDependencies.initialize();
    await loadAppConfig();
  }

  Future<void> loadAppConfig() async {
    (environment.isEmpty || environment == AppEnvironment.dev)
        ? await GlobalConfigs().loadJsonFromdir('assets/config/server_dev.json')
        : await GlobalConfigs()
            .loadJsonFromdir('assets/config/server_prod.json');
  }

  void configBannerEnv() {
    if (environment.isEmpty || environment == AppEnvironment.dev) {
      FlavorConfig(name: AppEnvironment.dev.toUpperCase(), color: Colors.red);
    } else if (environment == AppEnvironment.uat) {
      FlavorConfig(
          location: BannerLocation.bottomEnd,
          name: AppEnvironment.uat.toUpperCase(),
          color: Colors.red);
    } else {
      FlavorConfig();
    }
  }

  void _configShowLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..userInteractions = false
      ..indicatorColor = Colors.blueAccent
      ..backgroundColor = Colors.white
      ..dismissOnTap = false
      ..textColor = Colors.black38
      ..maskColor = Colors.black38
      ..maskType = EasyLoadingMaskType.black
      ..customAnimation = _CustomAnimation();
  }

  T? _getValue<T>(String key) {
    final value = GlobalConfigs().get<T>(key);
    return value;
  }

  String get baseUrl => _getValue<String>('baseUrl') ?? '';
  String get baseUrlApi => Uri.parse(baseUrl).origin;
}

class _CustomAnimation extends EasyLoadingAnimation {
  _CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
