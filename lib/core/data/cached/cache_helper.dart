import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void saveToken({required String value}) {
    sharedPreferences.setString('token', value);
  }
//delete token
  static void deleteToken() {
    sharedPreferences.remove('token');
  }
  
  static String? getToken() {
    return sharedPreferences.getString('token');
  }

  String? getDataString({
    required String key,
  }) {
    return sharedPreferences.getString(key);
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }

    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value ?? 0.0);
    }
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  Future<dynamic> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setInt(key, value);
    }
  }

  static Future<bool> saveJson({
    required String key,
    required Map<String, dynamic> json,
  }) async {
    final jsonString = jsonEncode(json);
    return await sharedPreferences.setString(key, jsonString);
  }

  static Map<String, dynamic>? getJson({required String key}) {
    final jsonString = sharedPreferences.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }
}
