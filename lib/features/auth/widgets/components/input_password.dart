import 'package:flutter/material.dart';

class InputPassword extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String errorMsg;
  final FormFieldValidator<String>? validator;

  const InputPassword(
      {super.key,
      required this.controller,
      required this.label,
      required this.hint,
      required this.errorMsg,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          hintText: hint,
          prefixIcon: Icon(Icons.key)),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return errorMsg;
            }
            return null;
          },
    );
  }
}
