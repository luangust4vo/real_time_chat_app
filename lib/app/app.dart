import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat_app/app/routes.dart';
import 'package:real_time_chat_app/features/welcome.dart';
import 'package:real_time_chat_app/features/chat/screens/chat.dart';
import 'package:real_time_chat_app/features/auth/screens/login.dart';
import 'package:real_time_chat_app/features/auth/screens/register.dart';
import 'package:real_time_chat_app/features/chat/screens/chat_list.dart';
import 'package:real_time_chat_app/features/settings/screens/settings.dart';
import 'package:real_time_chat_app/providers/theme_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return StreamBuilder<AuthState>(
            stream: Supabase.instance.client.auth.onAuthStateChange,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MaterialApp(
                  home: Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  ),
                );
              }

              final hasUser =
                  snapshot.hasData && snapshot.data?.session != null;

              return MaterialApp(
                title: 'Real Time Chat App',
                theme: ThemeData(
                  primaryColor: Colors.blueGrey,
                  brightness: themeProvider.isDarkMode
                      ? Brightness.dark
                      : Brightness.light,
                ),
                debugShowCheckedModeBanner: false,
                home: hasUser ? ChatList() : const Welcome(),
                routes: {
                  Routes.chat: (context) => const Chat(),
                  Routes.chat_list: (context) => ChatList(),
                  Routes.login: (context) => Login(),
                  Routes.register: (context) => Register(),
                  Routes.settings: (context) => const Settings(),
                },
              );
            });
      },
    );
  }
}
