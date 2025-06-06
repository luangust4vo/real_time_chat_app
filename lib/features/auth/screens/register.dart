import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/widgets/custom_scaffold.dart';
import 'package:real_time_chat_app/features/auth/widgets/custom_form.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: 'Register', body: CustomForm(formType: FormType.register));
    ;
  }
}
