import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themes {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.grey.shade100,
      colorScheme: ColorScheme.light(
        primary: Colors.blue,
        onPrimary: Colors.white,
        onSurface: Colors.blue,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
        displayMedium: TextStyle(
            fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.black),
        displaySmall: TextStyle(
            fontSize: 23.0, fontWeight: FontWeight.bold, color: Colors.black),
        headlineSmall: TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.black),
        titleSmall: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      iconTheme: IconThemeData(color: Colors.blue),
      cardColor: Colors.white,
      splashColor: Colors.cyan,
      shadowColor: Colors.grey,
      hintColor: Colors.grey,
      indicatorColor: Colors.red,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Color.fromRGBO(20, 21, 24, 1),
      scaffoldBackgroundColor: Color.fromRGBO(20, 21, 24, 1),
      colorScheme: ColorScheme.light(
        primary: Color.fromRGBO(20, 21, 24, 1),
        onPrimary: Colors.white,
        onSurface: Colors.grey.shade400,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
        displayMedium: TextStyle(
            fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
        displaySmall: TextStyle(
            fontSize: 23.0, fontWeight: FontWeight.bold, color: Colors.white),
        headlineSmall: TextStyle(
            fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      iconTheme: IconThemeData(color: Colors.grey.shade400),
      cardColor: Color.fromRGBO(34, 35, 40, 1),
      splashColor: Color.fromRGBO(20, 21, 24, 1),
      shadowColor: Color.fromRGBO(20, 21, 24, 1),
      hintColor: Colors.grey,
      indicatorColor: Colors.red,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
  }

  static isDarkMode() async {
    // Check if dark mode is enabled in app
    final prefs = await SharedPreferences.getInstance();
    bool isDarkModeSettedByUser = prefs.getBool(IS_DARK_MODE) != null;
    bool? isAppDarkMode = prefs.getBool(IS_DARK_MODE) == true;

    // Check if device is in dark mode
    Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDeviceDarkMode = brightness == Brightness.dark;

    return isDarkModeSettedByUser ? isAppDarkMode : isDeviceDarkMode;
  }
}
