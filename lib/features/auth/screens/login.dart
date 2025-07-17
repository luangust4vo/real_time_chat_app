import 'package:flutter/material.dart';
import 'package:real_time_chat_app/app/routes.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_scaffold.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_form.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_wrapper.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        body: AuthWrapper(
            title: 'Acesse sua conta',
            buttonText: 'Entrar',
            linkText: 'Não tem uma conta? Então cadastre',
            onSubmit: () => print('teste'),
            onLinkTap: () {
              Navigator.of(context).pushNamed(Routes.register);
            },
            form: AuthForm(
              formType: FormType.login,
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
            )));
  }
}
