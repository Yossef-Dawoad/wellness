import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  final SharedPreferencesAsync _prefs;
  final FlutterSecureStorage _secureStorage;

  SharedPrefHelper(this._prefs, this._secureStorage);

  Future<void> removeData(String key) async {
    await _prefs.remove(key);
    _log('Data with key: $key has been removed');
  }

  Future<void> clearAllData() async {
    await _prefs.clear();
    _log('All data has been cleared');
  }

  Future<void> setValue<T>(String key, T value) async {
    _log('Setting data with key: $key and value: $value with type: ${value.runtimeType}');

    return switch (T) {
      const (String) => await _prefs.setString(key, value as String),
      const (int) => await _prefs.setInt(key, value as int),
      const (bool) => await _prefs.setBool(key, value as bool),
      const (double) => await _prefs.setDouble(key, value as double),
      const (List<String>) => await _prefs.setStringList(key, value as List<String>),
      _ => throw UnsupportedError('Unsupported type: ${T.runtimeType}'),
    };
  }

  Future<T?> getValue<T>(String key) async {
    _log('Getting ${T.toString()} with key: $key');

    return switch (T) {
      const (String) => await _prefs.getString(key) as T?,
      const (int) => await _prefs.getInt(key) as T?,
      const (bool) => await _prefs.getBool(key) as T?,
      const (double) => await _prefs.getDouble(key) as T?,
      const (List<String>) => await _prefs.getStringList(key) as T?,
      _ => throw UnsupportedError('Unsupported type: ${T.runtimeType}'),
    };
  }

  Future<void> setSecuredString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
    _log('Secured string set with key: $key');
  }

  Future<String?> getSecuredString(String key) async {
    final value = await _secureStorage.read(key: key);
    _log('Getting secured string with key: $key');
    return value;
  }

  Future<void> clearSecuredData(String key) async {
    await _secureStorage.delete(key: key);
    _log('secured data with the following key: $key has been cleared');
  }

  Future<void> clearAllSecuredData() async {
    await _secureStorage.deleteAll();
    _log('All secured data has been cleared');
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('SharedPrefHelper: $message');
    }
  }
}
