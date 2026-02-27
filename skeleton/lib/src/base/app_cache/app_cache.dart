import 'dart:convert';

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/convert_utils.dart';

abstract class BaseUserPreferences {
  Future<dynamic> get(String key, {bool isDateTime = false});
  Future<bool> set(String key, dynamic value, {bool encrypted = false});
  Future<bool> remove(String key);
  Future<bool> clearAll();
}

class UserPreference extends BaseUserPreferences {
  final prefs = EncryptedSharedPreferences.getInstance();
  @override
  Future<dynamic> get(String key,
      {bool isDateTime = false, bool encrypted = false}) async {
    if (isDateTime) {
      return ConvertUtility.convertPreferenceDate((prefs.getString(key)) ?? '');
    }
    return prefs.getString(key);
  }

  @override
  Future<bool> set(String key, dynamic value, {bool encrypted = false}) async {
    try {
      encrypted
          ? await setEncrypted(key, value)
          : await setNonEncrypted(key, value);
      return true;
    } catch (ex) {
      rethrow;
    }
  }

  Future<dynamic> setPrefPauseTime(String key, String value) async {
    if (value.isEmpty) {
      await prefs.setString(key, 'null');
    } else {
      await prefs.setString(key, value);
    }
  }

  Future<DateTime?> getPrefPauseTime(String key,
      {bool isDateTime = false}) async {
    var pauseTime = (prefs.getString(key)) ?? '';
    if (pauseTime.isNotEmpty && pauseTime != 'null') {
      return ConvertUtility.convertPreferenceDate(pauseTime);
    }
    return null;
  }

  Future<void> setEncrypted(String key, dynamic value) async {
    if (value != null) {
      if (value is int) {
        await prefs.setInt(key, value);
      } else if (value is double) {
        await prefs.setDouble(key, value);
      } else if (value is bool) {
        await prefs.setBoolean(key, value);
      } else if (value is String) {
        await prefs.setString(key, value);
      } else if (value is List<String>) {
        await prefs.setString(key, json.encode(value));
      } else {
        throw Exception('Value type is not supported');
      }
    }
  }

  Future<void> setNonEncrypted(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value != null) {
      if (value is int) {
        await prefs.setInt(key, value);
      } else if (value is double) {
        await prefs.setDouble(key, value);
      } else if (value is bool) {
        await prefs.setBool(key, value);
      } else if (value is String) {
        await prefs.setString(key, value);
      } else if (value is List<String>) {
        await prefs.setStringList(key, value);
      } else {
        throw Exception('Value type is not supported');
      }
    }
  }

  Future<dynamic> getLocalWithNonEncrypted(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) return prefs.get(key);
    return null;
  }

  @override
  Future<bool> remove(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(key)) await prefs.remove(key);
      return true;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<bool> clearAll() {
    return prefs.clear();
  }
}
