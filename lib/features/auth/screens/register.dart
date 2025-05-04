import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/widgets/scaffold.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Register',
      body: Center(
        child: Text('Register Screen',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
    ;
  }
}
