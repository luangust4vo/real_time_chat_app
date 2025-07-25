import 'package:flutter/material.dart';

class InputEmail extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final bool isRequired;

  const InputEmail(
      {super.key,
      required this.controller,
      this.label = 'E-mail',
      this.hint = 'nome@provedora.com',
      this.validator,
      this.isRequired = true});

  String? _validate(String? value) {
    if ((value == null || value.isEmpty) && isRequired) {
      return 'Informe o e-mail';
    } else {
      final regex = RegExp(
        r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
      );

      if (!regex.hasMatch(value!)) return 'Informe um e-mail válido';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.email),
        border: const OutlineInputBorder(),
      ),
      validator: validator ?? _validate,
      autofillHints: const [AutofillHints.email],
    );
  }
}
