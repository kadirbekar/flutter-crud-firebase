import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_example_with_cloud_storage/core/services/local_storage_service.dart';
import 'package:test_example_with_cloud_storage/ui/shared/ui_text.dart' as text;

class ThemeService with ChangeNotifier {
  bool _getTheme = LocalStorageService.getThemeValue;

  bool get getTheme => _getTheme;

  //save new value into shared preferences with that way
  //we won't lose our value for theme
  set getTheme(bool value) {
    _getTheme = value;
    LocalStorageService.setTheme(value);
    notifyListeners();
  }

  /*Assign own colors that you are gonna use when theme is changed*/
  ThemeData darkTheme = ThemeData(
    fontFamily: text.generalFontStyle,
    brightness: Brightness.dark,
    primarySwatch: Colors.red,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
      size: 38,
      color: Colors.white,
    ),
    accentColor: Colors.purple,
    accentIconTheme: IconThemeData(
      color: Colors.white,
    ),
  );

  ThemeData lightTheme = ThemeData(
    fontFamily: text.generalFontStyle,
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
    ),
    iconTheme: IconThemeData(
      size: 38,
      color: Colors.black,
    ),
    accentColor: Colors.teal,
    accentIconTheme: IconThemeData(
      color: Colors.black,
    ),
  );
}
