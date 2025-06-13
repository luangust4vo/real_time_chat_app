import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;

  const AuthScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      body: SafeArea(child: body),
    );
  }
}
