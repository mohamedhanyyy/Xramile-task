import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static SharedPreferences? preferences;

  static void init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken({required String token}) async {
    await preferences?.setString('token', token);
  }

  static Future<void> saveLang({required String lang}) async {
    await preferences?.setString('lang', lang);
  }

  static String? getLang() {
    return preferences?.getString('lang') ?? 'ar';
  }

  static Future saveIsFirstOpenApp({required bool value}) async {
    await preferences?.setBool('isFirstOpenApp', value);
  }

  static bool get isFirstOpenApp {
    return preferences?.getBool('isFirstOpenApp') ?? false;
  }

  static Future saveEnableNotifications(
      {required bool isEnableNotification}) async {
    await preferences?.setBool('enableNotification', isEnableNotification);
  }

  static bool get isEnableNotifications =>
      preferences?.getBool('enableNotification') ?? false;

  static void logOut() {
    preferences?.remove('token');
    preferences?.remove('userModel');
    preferences?.remove('keepMeLogged');
  }
}
