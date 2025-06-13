import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/widgets/generic_scaffold.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      title: 'Settings',
      body: Center(
        child: Text('Settings Screen',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
