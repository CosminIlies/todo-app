import 'package:flutter/material.dart';
import 'package:todo_app/uitls/helper_widgets.dart';

class Register extends StatefulWidget {
  Function callback;

  Register({super.key, required this.callback});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Register',
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
          const TextField(
            decoration: InputDecoration(
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
          ElevatedButton(onPressed: () {}, child: const Text('Register')),
        ],
      ),
    );
  }
}
