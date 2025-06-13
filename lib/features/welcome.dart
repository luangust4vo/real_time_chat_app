import 'package:flutter/material.dart';
import 'package:real_time_chat_app/app/routes.dart';
import 'package:real_time_chat_app/core/widgets/generic_button.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_scaffold.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.chat_bubble_outline,
                size: 80,
                color: Color(0xFF0088CC),
              ),
              const SizedBox(height: 20),
              const Text(
                'ZapTime',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0088CC),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Converse com seus amigos em tempo real, onde quiser!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),
              GenericButton(
                icon: Icon(Icons.login),
                text: 'Entrar',
                backgroundColor: const Color(0xFF0088CC),
                textColor: Colors.white,
                width: double.infinity,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
              ),
              const SizedBox(height: 16),
              GenericButton(
                  outlined: true,
                  icon: Icon(Icons.person_add),
                  text: 'Cadastrar-se',
                  backgroundColor: Colors.white,
                  textColor: const Color(0xFF0088CC),
                  width: double.infinity,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
