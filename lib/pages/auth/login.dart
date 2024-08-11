import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/uitls/helper_widgets.dart';

class Login extends StatefulWidget {
  Function callback;
  Login({super.key, required this.callback});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Email'),
              hintText: 'Enter your username',
            ),
          ),
          addVerticalSpace(20),
          const TextField(
            decoration: InputDecoration(
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
          ElevatedButton(onPressed: () {}, child: const Text('Login')),
        ],
      ),
    );
  }
}
