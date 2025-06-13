import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/widgets/generic_scaffold.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_form.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
        title: 'Register', body: CustomForm(formType: FormType.register));
  }
}
