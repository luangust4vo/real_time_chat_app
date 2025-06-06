import 'package:flutter/material.dart';

class InputPassword extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String errorMsg;

  const InputPassword(
      {super.key,
      required this.controller,
      required this.label,
      required this.hint,
      required this.errorMsg});
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
      validator: (value) => value == null || value.isEmpty ? errorMsg : null,
    );
  }
}
