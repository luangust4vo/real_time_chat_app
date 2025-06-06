import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/auth/widgets/components/input_email.dart';
import 'package:real_time_chat_app/features/auth/widgets/components/input_password.dart';

enum FormType { login, register }

class CustomForm extends StatefulWidget {
  final FormType formType;

  const CustomForm({super.key, required this.formType});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (widget.formType == FormType.register) ...[
              TextFormField(
                controller: _nameController,
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
                controller: _dateOfBirthController,
                // onTap: () => _selectDate(context),
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
            InputEmail(controller: _emailController),
            const SizedBox(height: 16),
            InputPassword(
                controller: _passwordController,
                label: 'Insira sua senha',
                hint: 'joao123',
                errorMsg: 'O campo senha não pode ser vazio'),
            if (widget.formType == FormType.register) ...[
              const SizedBox(height: 16),
              InputPassword(
                  controller: _confirmPasswordController,
                  label: 'Confirme sua senha',
                  hint: 'joao123',
                  errorMsg: 'As senhas não coincidem')
            ]
          ],
        ),
      ),
    );
  }
}
