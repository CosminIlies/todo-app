import 'dart:ffi';

import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF8EDE3),
    primaryColor: const Color(0xFFD0B8A8),
    primaryColorDark: Color.fromARGB(255, 170, 148, 134),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFFF8EDE3),
    ),
    colorScheme: const ColorScheme.light(
      secondary: Color(0xFF7D6E83),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF7D6E83),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Color(0xFF7D6E83),
        ), //button color
        foregroundColor: MaterialStateProperty.all<Color>(
          Color(0xffffffff),
        ), //text (and icon)
      ),
    ));
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 87, 74, 66),
    primaryColor: Color.fromARGB(255, 190, 156, 133),
    primaryColorDark: Color.fromARGB(255, 139, 114, 97),
    colorScheme: const ColorScheme.dark(
      secondary: Color(0xFF704C7E),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color.fromARGB(255, 87, 74, 66),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF704C7E),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Color(0xFF704C7E),
        ), //button color
        foregroundColor: MaterialStateProperty.all<Color>(
          Color(0xffffffff),
        ), //text (and icon)
      ),
    ));
