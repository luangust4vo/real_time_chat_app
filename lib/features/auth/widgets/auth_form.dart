import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_time_chat_app/features/auth/widgets/components/input_email.dart';
import 'package:real_time_chat_app/features/auth/widgets/components/input_password.dart';

enum FormType { login, register }

class AuthForm extends StatefulWidget {
  final FormType formType;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? nameController;
  final TextEditingController? confirmPasswordController;
  final TextEditingController? dateOfBirthController;

  const AuthForm({
    super.key,
    required this.formType,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    this.nameController,
    this.confirmPasswordController,
    this.dateOfBirthController,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.dateOfBirthController!.text =
            DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (widget.formType == FormType.register) ...[
              TextFormField(
                controller: widget.nameController!,
                decoration: InputDecoration(
                    labelText: 'Nome', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O campo nome não pode ser vazio';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16)
            ],
            if (widget.formType == FormType.register) ...[
              TextFormField(
                readOnly: true, // Para evitar que insira a data na mão
                controller: widget.dateOfBirthController!,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                    labelText: 'Data de Nascimento',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O campo data de nascimento não pode ser vazio';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16)
            ],
            InputEmail(controller: widget.emailController),
            const SizedBox(height: 16),
            InputPassword(
                controller: widget.passwordController,
                label: 'Insira sua senha',
                hint: 'joao123',
                errorMsg: 'O campo senha não pode ser vazio'),
            if (widget.formType == FormType.register) ...[
              const SizedBox(height: 16),
              InputPassword(
                  controller: widget.confirmPasswordController!,
                  label: 'Confirme sua senha',
                  hint: 'joao123',
                  errorMsg: 'As senhas não coincidem',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirme sua senha';
                    }
                    // Compara o valor deste campo com o valor do campo de senha original
                    if (value != widget.passwordController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  }),
            ]
          ],
        ),
      ),
    );
  }
}
