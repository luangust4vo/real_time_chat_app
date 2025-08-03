import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_time_chat_app/utils/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;

  Future<bool> signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String dateOfBirth,
  }) async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd')
          .format(DateFormat('dd/MM/yyyy').parse(dateOfBirth.trim()));

      final AuthResponse res = await _supabase.auth.signUp(
        email: email.trim(),
        password: password.trim(),
        data: {'name': name.trim(), 'date_of_birth': formattedDate},
      );

      if (res.user != null && context.mounted) {
        showSnackbar(context,
            'Registro realizado! Verifique seu e-mail para confirmar a conta.',
            type: SnackbarType.success);
      }

      return true;
    } on AuthException catch (e) {
      if (context.mounted) {
        showSnackbar(context, 'Erro no registro: ${e.toString()}',
            type: SnackbarType.error);
      }

      return false;
    } catch (e) {
      if (context.mounted) {
        showSnackbar(context, 'Ocorreu um erro inesperado. Tente novamente.',
            type: SnackbarType.error);
      }

      return false;
    }
  }

  Future<bool> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user != null && context.mounted) {
        showSnackbar(context, 'Login bem-sucedido!',
            type: SnackbarType.success);
      }

      return true;
    } on AuthException catch (e) {
      if (context.mounted) {
        showSnackbar(context, 'Erro no login: ${e.message}',
            type: SnackbarType.error);
      }

      return false;
    } catch (e) {
      if (context.mounted) {
        showSnackbar(context, 'Ocorreu um erro inesperado. Tente novamente.',
            type: SnackbarType.error);
      }

      return false;
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _supabase.auth.signOut();
    } on AuthException catch (e) {
      if (context.mounted) {
        showSnackbar(context, 'Erro ao fazer logout: ${e.message}',
            type: SnackbarType.error);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackbar(context, 'Ocorreu um erro inesperado. Tente novamente.',
            type: SnackbarType.error);
      }
    }
  }
}
