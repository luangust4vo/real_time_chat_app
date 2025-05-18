import 'package:flutter/material.dart';
import 'package:real_time_chat_app/app/routes.dart';
import 'package:real_time_chat_app/core/widgets/custom_elevated_button.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bem Vindo!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'Entrar',
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.login);
              },
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.register);
              },
              text: 'Registrar',
            ),
          ],
        ),
      ),
    );
  }
}
