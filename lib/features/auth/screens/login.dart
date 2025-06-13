import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/widgets/generic_scaffold.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_form.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
        title: 'Login', body: CustomForm(formType: FormType.login));
  }
}
