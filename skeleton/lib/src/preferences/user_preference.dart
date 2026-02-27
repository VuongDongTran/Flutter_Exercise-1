import 'package:shared_preferences/shared_preferences.dart';

import '../base/utils/convert_utils.dart';

abstract class UserPreference {
  Future<dynamic> getValue(String key);
  Future<bool> setValue(String key, dynamic value);
  Future<void> remove(String key);
  Future<void> clearAll();
}

class ImplUserPreference extends UserPreference {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ImplUserPreference();

  @override
  Future<void> clearAll() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.clear();
  }

  @override
  Future<bool> remove(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(key);
  }

  @override
  Future<bool> setValue(String key, dynamic value) async {
    try {
      final SharedPreferences prefs = await _prefs;
      if (value is bool) {
        return prefs.setBool(key, value);
      } else if (value is int) {
        return prefs.setInt(key, value);
      } else if (value is double) {
        return prefs.setDouble(key, value);
      } else if (value is String) {
        return prefs.setString(key, value);
      } else if (value is List<String>) {
        return prefs.setStringList(key, value);
      } else if (value is DateTime) {
        final time = ConvertUtility.convertDateTimeToString(
            dateTime: value, format: ConvertUtility.dateFormatUTC);
        return prefs.setString(key, time ?? '');
      }
    } catch (ex) {
      throw Exception('Can not save invalid value: $ex');
    }
    throw Exception('Can not save invalid value');
  }

  @override
  Future<dynamic> getValue(String key) async {
    try {
      final SharedPreferences prefs = await _prefs;
      var value = prefs.get(key);
      return Future.value(value);
    } catch (ex) {
      throw Exception('Can not get invalid value');
    }
  }
}
