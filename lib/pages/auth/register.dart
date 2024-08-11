import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/uitls/helper_widgets.dart';
import 'package:todo_app/uitls/validation.dart';

class Register extends StatefulWidget {
  Function callback;

  Register({super.key, required this.callback});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  String? emailError;
  String? passwordError;
  String? repeatPasswordError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Register',
                style: TextStyle(fontSize: 30),
              ),
              addVerticalSpace(20),
              TextField(
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
              TextField(
                controller: repeatPasswordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  errorText: repeatPasswordError,
                  border: OutlineInputBorder(),
                  label: Text('Repeate Password'),
                  hintText: 'Enter your password again',
                ),
              ),
              addVerticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.callback(true);
                    },
                    child: const Text(
                      'Login',
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
                    final repeatPassword = repeatPasswordController.text;

                    setState(() {
                      emailError = validateEmail(email);
                      passwordError = validatePassword(password);
                      repeatPasswordError =
                          validateRepeatPassword(password, repeatPassword);
                    });

                    if (emailError == null &&
                        passwordError == null &&
                        repeatPasswordError == null) {
                      AuthService.register(email, password).then((val) {
                        if (!val) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Registration failed'),
                          ));
                          return;
                        }
                        Navigator.pushReplacementNamed(context, '/main');
                      });
                    }
                  },
                  child: const Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}
