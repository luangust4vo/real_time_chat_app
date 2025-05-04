import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat_app/app/app.dart';
import 'package:real_time_chat_app/providers/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const App(),
  ));
}
