import 'package:flutter/material.dart';
import 'package:real_time_chat_app/app/routes.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_scaffold.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_form.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_wrapper.dart';
import 'package:real_time_chat_app/features/auth/services/auth_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() => _isLoading = true);

    await _authService.signUp(
      context: context,
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _nameController.text.trim(),
      dateOfBirth: _dateOfBirthController.text.trim(),
    );

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        body: AuthWrapper(
            title: 'Crie sua conta',
            buttonText: 'Cadastrar',
            linkText: 'Já tem uma conta? Então entre',
            onSubmit: _submit,
            onLinkTap: () {
              Navigator.of(context).pushNamed(Routes.login);
            },
            isLoading: _isLoading,
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
