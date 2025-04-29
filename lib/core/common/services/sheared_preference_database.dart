import 'package:shared_preferences/shared_preferences.dart';
class GenderDataBaseShearedPreference {
 static Future<void>saveGenderType(String key ,String selectedType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, selectedType);
  }
  static Future<String?>getGenderType(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

}

