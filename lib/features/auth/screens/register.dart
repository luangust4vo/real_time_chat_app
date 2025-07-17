import 'package:flutter/material.dart';
import 'package:real_time_chat_app/app/routes.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_scaffold.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_form.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_wrapper.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        body: AuthWrapper(
            title: 'Crie sua conta',
            buttonText: 'Cadastrar',
            linkText: 'Já tem uma conta? Então entre',
            onSubmit: () => print('teste'),
            onLinkTap: () {
              Navigator.of(context).pushNamed(Routes.login);
            },
            form: AuthForm(
              formType: FormType.register,
              formKey: _formKey,
              emailController: _emailController,
              nameController: _nameController,
              dateOfBirthController: _dateOfBirthController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
            )));
  }
}
