import 'package:flutter/material.dart';
import 'package:real_time_chat_app/app/routes.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_scaffold.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_form.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_wrapper.dart';
import 'package:real_time_chat_app/features/auth/services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() => _isLoading = true);

    final bool success = await _authService.signIn(
      context: context,
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (mounted) {
      setState(() => _isLoading = false);

      if (success) {
        Navigator.of(context).pushReplacementNamed(Routes.chat_list);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        body: AuthWrapper(
            title: 'Acesse sua conta',
            buttonText: 'Entrar',
            linkText: 'Não tem uma conta? Então cadastre',
            onSubmit: _submit,
            onLinkTap: () {
              Navigator.of(context).pushNamed(Routes.register);
            },
            isLoading: _isLoading,
            form: AuthForm(
              formType: FormType.login,
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
            )));
  }
}
