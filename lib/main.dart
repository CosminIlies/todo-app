import 'package:flutter/material.dart';
import 'package:todo_app/pages/auth/auth.dart';
import 'package:todo_app/pages/auth/login.dart';
import 'package:todo_app/pages/auth/register.dart';
import 'package:todo_app/pages/main_page.dart';
import 'package:todo_app/theme/theme_constants.dart';
import 'package:todo_app/theme/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    print(themeManager.themeMode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MainPage();
  }
}
