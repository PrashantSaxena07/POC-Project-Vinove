import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:v6001_prashant_saxena/constants/color.dart';

enum AppTheme { dark, light, winter, summer, autumn }

class ThemeProvider extends ChangeNotifier {
  late ThemeData themeMode;
  late AppTheme _appTheme;
  AppTheme get appTheme => _appTheme;

  ThemeProvider.initializer() {
    _appTheme = AppTheme.dark;
    getTheme();
  }

  void setTheme(AppTheme appTheme) {
    _appTheme = appTheme;
    getTheme();
    notifyListeners();
  }

  // bool get isDarkMode {
  //   if (themeMode == ThemeMode.system) {
  //     final brightness = SchedulerBinding.instance?.window.platformBrightness;
  //     return brightness == Brightness.dark;
  //   } else {
  //     return themeMode == ThemeMode.dark;
  //   }
  // }

  // void toggleTheme(bool isOn) {
  //   themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
  //   notifyListeners();
  // }

  void getTheme() {
    if (_appTheme == AppTheme.light) {
      themeMode = ThemeData(
        scaffoldBackgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.teal),
        primaryColor: Color.fromRGBO(0, 167, 131, 1),
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(0, 167, 131, 1),
        ),
      );
    } else if (_appTheme == AppTheme.dark) {
      themeMode = ThemeData(
        primaryColor: messageColor,
        scaffoldBackgroundColor: Color.fromRGBO(26, 47, 54, 1),
        iconTheme: IconThemeData(color: Colors.grey, opacity: 0.8),
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(29, 53, 61, 1),
        ),
        colorScheme: ColorScheme.dark(),
      );
    } else if (_appTheme == AppTheme.summer) {
      themeMode = ThemeData(
        scaffoldBackgroundColor: Color(0xffFDAF75),
        iconTheme: IconThemeData(color: Color(0xFF333C83)),
        primaryColor: Color(0xffEAEA7F),
        appBarTheme: AppBarTheme(
          color: Color(0xFFF24A72),
        ),
        colorScheme: ColorScheme.light(),
      );
    } else if (_appTheme == AppTheme.winter) {
      themeMode = ThemeData(
        scaffoldBackgroundColor: Color(0xFF6998AB),
        iconTheme: IconThemeData(color: Color(0xFF1A374D)),
        primaryColor: Color(0xFFB1D0E0),
        appBarTheme: AppBarTheme(
          color: Color(0xFF406882),
        ),
        colorScheme: ColorScheme.light(),
      );
    } else {
      themeMode = ThemeData(
        scaffoldBackgroundColor: Color(0xFFFDAF75),
        iconTheme: IconThemeData(color: Color(0XFFF24A72)),
        primaryColor: Color(0xFFEAEA7F),
        appBarTheme: AppBarTheme(
          color: Color(0xFF333C83),
        ),
        colorScheme: ColorScheme.light(),
      );
    }
    ;
  }
}

/*
class MyThemes {
  static final darkTheme =
  ThemeData(
    primaryColor: messageColor,
    scaffoldBackgroundColor: Color.fromRGBO(26,47,54, 1),
    iconTheme: IconThemeData(color: Colors.grey, opacity: 0.8),
    appBarTheme: AppBarTheme(
      color: Color.fromRGBO(29,53,61,1),
    ),
    colorScheme: ColorScheme.dark(),

  );
  static final lightTheme =
  ThemeData(
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.teal),
    primaryColor: Color.fromRGBO(0, 167, 131, 1),
    appBarTheme: AppBarTheme(
      color: Color.fromRGBO(0, 167, 131, 1),
    ),
    colorScheme: ColorScheme.light(),
  );
  static final summerTheme =
  ThemeData(
    scaffoldBackgroundColor: Color(0xffFDAF75),
    iconTheme: IconThemeData(color: Color(0xFF333C83)),
    primaryColor: Color(0xffEAEA7F),
    appBarTheme: AppBarTheme(
      color: Color(0xFFF24A72),
    ),
    colorScheme: ColorScheme.light(),
  );
  static final winterTheme =
  ThemeData(
    scaffoldBackgroundColor: Color(0xFF6998AB),
    iconTheme: IconThemeData(color: Color(0xFF1A374D)),
    primaryColor: Color(0xFFB1D0E0),
    appBarTheme: AppBarTheme(
      color: Color(0xFF406882),
    ),
    colorScheme: ColorScheme.light(),
  );
  static final autumnTheme =
  ThemeData(
    scaffoldBackgroundColor: Color(0xFFFDAF75),
    iconTheme: IconThemeData(color: Color(0XFFF24A72)),
    primaryColor: Color(0xFFEAEA7F),
    appBarTheme: AppBarTheme(
      color: Color(0xFF333C83),
    ),
    colorScheme: ColorScheme.light(),
  );
}*/
