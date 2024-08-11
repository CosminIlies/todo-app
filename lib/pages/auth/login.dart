import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/uitls/helper_widgets.dart';
import 'package:todo_app/uitls/validation.dart';

class Login extends StatefulWidget {
  Function callback;
  Login({super.key, required this.callback});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // String email = '';
  // String password = '';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(fontSize: 30),
          ),
          addVerticalSpace(20),
          TextField(
            // onChanged: (value) {
            //   email = value;
            // },
            controller: emailController,
            decoration: InputDecoration(
              errorText: emailError,
              border: OutlineInputBorder(),
              label: Text('Email'),
              hintText: 'Enter your username',
            ),
          ),
          addVerticalSpace(20),
          TextField(
            // onChanged: (value) {
            //   password = value;
            // },
            controller: passwordController,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              errorText: passwordError,
              border: OutlineInputBorder(),
              label: Text('Password'),
              hintText: 'Enter your password',
            ),
          ),
          addVerticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "You don't have an account? ",
                style: TextStyle(fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  widget.callback(false);
                },
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          addVerticalSpace(20),
          ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;

                setState(() {
                  emailError = validateEmail(email);
                  passwordError = validatePassword(password);
                });

                if (emailError == null && passwordError == null) {
                  print(email);
                  print(password);
                  AuthService.login(email, password).then((value) {
                    if (!value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid credentials')));
                      return;
                    }

                    Navigator.pushReplacementNamed(context, '/main');
                  });
                }
              },
              child: const Text('Login')),
        ],
      ),
    );
  }
}
