import 'package:flutter/material.dart';
import 'package:real_time_chat_app/app/routes.dart';
import 'package:real_time_chat_app/screens/chat.dart';
import 'package:real_time_chat_app/screens/home.dart';
import 'package:real_time_chat_app/screens/login.dart';
import 'package:real_time_chat_app/screens/profile.dart';
import 'package:real_time_chat_app/screens/register.dart';
import 'package:real_time_chat_app/screens/settings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Time Chat App',
      theme: ThemeData(primaryColor: Colors.blueGrey),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const Home(),
        Routes.login: (context) => const Login(),
        Routes.register: (context) => const Register(),
        Routes.chat: (context) => const Chat(),
        Routes.profile: (context) => const Profile(),
        Routes.settings: (context) => const Settings(),
      },
    );
  }
}
