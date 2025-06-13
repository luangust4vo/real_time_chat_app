import 'package:flutter/material.dart';

class GenericScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget body;
  final List<Widget>? actions;

  const GenericScaffold({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    required this.body,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: leading,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        actions: actions,
      ),
      body: body,
    );
  }
}
