import 'package:flutter/material.dart';
import 'package:todo_app/pages/auth/login.dart';
import 'package:todo_app/pages/auth/register.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool isLoginPage = true;

  changePage(bool page) {
    setState(() {
      isLoginPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Todo App'),
        ),
        body: isLoginPage
            ? Login(callback: this.changePage)
            : Register(callback: this.changePage));
  }
}
