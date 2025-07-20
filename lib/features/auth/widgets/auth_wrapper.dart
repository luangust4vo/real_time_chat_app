import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/auth/widgets/auth_form.dart';

class AuthWrapper extends StatelessWidget {
  final String title;
  final String buttonText;
  final String linkText;
  final VoidCallback onSubmit;
  final VoidCallback onLinkTap;
  final AuthForm form;
  final bool isLoading;

  const AuthWrapper({
    super.key,
    required this.title,
    required this.buttonText,
    required this.linkText,
    required this.onSubmit,
    required this.onLinkTap,
    required this.form,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 32),
            form,
            const SizedBox(height: 24),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSubmit,
                  child: Text(buttonText),
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSubmit,
                child: Text(buttonText),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: onLinkTap,
              child: Text(
                linkText,
                style: const TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ),
    );
  }
}
