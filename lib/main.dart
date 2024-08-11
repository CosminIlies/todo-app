import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/pages/auth/auth.dart';
import 'package:todo_app/pages/main_page.dart';
import 'package:todo_app/pages/settings.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/messaging_service.dart';
import 'package:todo_app/theme/theme_constants.dart';
import 'package:todo_app/theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthService.initialize();
  await MessagingService().init();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const Main());
}

ThemeManager themeManager = ThemeManager();

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
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      home: AuthService.user == null
          ? const AuthenticationPage()
          : const MainPage(),
      routes: {
        "/main": (context) => AuthService.user == null
            ? const AuthenticationPage()
            : const MainPage(),
        "/settings": (context) => Settings(
              themeManager: themeManager,
            ),
      },
    );
  }
}
