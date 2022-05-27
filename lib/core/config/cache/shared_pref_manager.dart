import "package:shared_preferences/shared_preferences.dart";

class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  static SharedPreferencesManager get instance {
    _instance ??= SharedPreferencesManager._init();
    return _instance!;
  }

  SharedPreferencesManager._init();

  late SharedPreferences preferences;

  Future<SharedPreferences> initialize() async {
    preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<void> setStringValue(String key, String value) async {
    await preferences.setString(key, value);
  }

  String? getStringValue(String key) {
    return preferences.getString(key);
  }

  Future<void> removeValue(String key) async {
    await preferences.remove(key);
  }
}
