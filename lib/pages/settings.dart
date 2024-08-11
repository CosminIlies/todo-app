import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/theme/theme_manager.dart';
import 'package:todo_app/uitls/helper_widgets.dart';

class Settings extends StatefulWidget {
  final ThemeManager themeManager;
  const Settings({super.key, required this.themeManager});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool darkTheme = themeManager.themeMode == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Settings',
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addVerticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Dark Theme: "),
                Switch(
                    value: darkTheme,
                    onChanged: (val) {
                      setState(() {
                        darkTheme = val;
                        themeManager.toggleTheme(val);
                      });
                    })
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  await AuthService.signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/main');
                },
                child: const Text("Logout"))
          ],
        ));
  }
}
