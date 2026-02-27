import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import '../app_dependency.dart';
import '../common/constants.dart';
import '../preferences/user_preference.dart';
import 'route_key.dart';

class AuthGuard {
  final pref = AppDependencies.injector.get<UserPreference>();

  Future<bool> checkAuth(BuildContext context, {bool redirect = true}) async {
    if (await isAuthenticated()) {
      return true;
    } else {
      if (redirect) {
        Navigator.of(context).pushReplacementNamed(RouteKey.login);
      }
      return false;
    }
  }

  Future<bool> isAuthenticated() async {
    final String accessToken =
        await pref.getValue(UserSharedPreferencesPath.token) ?? '';
    final String refreshToken =
        await pref.getValue(UserSharedPreferencesPath.refreshToken) ?? '';
    return StringUtils.isNotNullOrEmpty(accessToken) &&
        StringUtils.isNotNullOrEmpty(refreshToken);
  }

  Future<bool> clearDataLocal() async {
    try {
      await pref.clearAll();
    } catch (e) {
      return false;
    }
    return true;
  }
}
