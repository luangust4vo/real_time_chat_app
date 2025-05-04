import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat_app/app/routes.dart';
import 'package:real_time_chat_app/features/chat/screens/chat.dart';
import 'package:real_time_chat_app/features/auth/screens/login.dart';
import 'package:real_time_chat_app/features/auth/screens/register.dart';
import 'package:real_time_chat_app/features/chat/screens/chat_list.dart';
import 'package:real_time_chat_app/features/settings/screens/settings.dart';
import 'package:real_time_chat_app/providers/theme_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Real Time Chat App',
          theme: ThemeData(
            primaryColor: Colors.blueGrey,
            brightness:
                themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.chat,
          routes: {
            Routes.chat: (context) => const Chat(),
            Routes.chat_list: (context) => const ChatList(),
            Routes.login: (context) => const Login(),
            Routes.register: (context) => const Register(),
            Routes.settings: (context) => const Settings(),
          },
        );
      },
    );
  }
}
