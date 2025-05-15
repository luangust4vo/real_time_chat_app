import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/widgets/custom_scaffold.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Login',
      body: Center(
        child: Text('Login Screen',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
    ;
  }
}
