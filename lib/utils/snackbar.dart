import 'package:flutter/material.dart';

enum SnackbarType { success, error }

void showSnackbar(BuildContext context, String message,
    {SnackbarType type = SnackbarType.success}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  final Color backgroundColor = type == SnackbarType.success
      ? Colors.green.shade600
      : Colors.red.shade600;

  final snackbar = SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    margin: const EdgeInsets.all(10.0),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
