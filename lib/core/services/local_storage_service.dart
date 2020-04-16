import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_example_with_cloud_storage/ui/shared/ui_text.dart' as text;

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  /*it checks if this service class 
  used before or not it if is return first instance*/
  static initialize() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  
  //Save values if the user logged before 
  static Future<void> saveMail(String mail) async {
    return _preferences.setString(text.mailKey, mail);
  }

  static Future<void> saveLogin(bool checkLogin) async {
    return _preferences.setBool(text.loginKey, checkLogin);
  }

  static Future<void> savePassword(String password) async {
    return _preferences.setString(text.passwordKey, password);
  }

  static Future<void> saveName(String name) async {
    return _preferences.setString(text.nameKey, name);
  }

  static Future<void> saveId(String id) async {
    return _preferences.setString(text.idKey, id);
  }

  static Future<void> saveImage(String image) async {
    return _preferences.setString(text.image, image);
  }

  static Future<void> setTheme(bool newValue) async {
    return _preferences.setBool(text.themeValue, newValue);
  }

  

  //Get values with key
  static String get getUserMail => _preferences.getString(text.mailKey) ?? "";
  static String get getUserPassword => _preferences.getString(text.passwordKey) ?? "";
  static String get getUserId => _preferences.getString(text.idKey) ?? "";
  static String get getUserName => _preferences.getString(text.nameKey) ?? "";
  static bool get getLogin => _preferences.getBool(text.loginKey) ?? false;
  static bool get getThemeValue => _preferences.getBool(text.themeValue) ?? false;
  static String get getImage => _preferences.getString(text.image) ?? "";
}
