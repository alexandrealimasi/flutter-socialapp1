import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _token = "user_token";
  // static const String _counter = "counter";
  static const String uniqueIserId = "unique_user_id";

  String value = "";

  static SharedPreferences? instance;

  UserPreferences() {
    init();
  }
  static Future<void> init() async {
    instance ??= await SharedPreferences.getInstance();
  }

  static String get token {
    return instance!.getString(_token) ?? '';
  }

  static set token(value) {
    instance!.setString(_token, value);
  }

  static String get uuid {
    return instance!.getString(uniqueIserId) ?? '';
  }

  static set uuid(value) {
    instance!.setString(uniqueIserId, value);
  }
}
