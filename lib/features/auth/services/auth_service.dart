import 'package:flutter/material.dart';
import 'package:real_time_chat_app/utils/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;

  Future<void> signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String dateOfBirth,
  }) async {
    try {
      final AuthResponse res = await _supabase.auth.signUp(
        email: email,
        password: password,
        // 'data' permite salvar informações adicionais no perfil do usuário
        data: {'name': name, 'date_of_birth': dateOfBirth},
      );

      if (res.user != null && context.mounted) {
        showSnackbar(context,
            'Registro realizado! Verifique seu e-mail para confirmar a conta.',
            type: SnackbarType.success);
      }
    } on AuthException catch (e) {
      if (context.mounted) {
        showSnackbar(context, 'Erro no registro: ${e.message}',
            type: SnackbarType.error);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackbar(context, 'Ocorreu um erro inesperado. Tente novamente.',
            type: SnackbarType.error);
      }
    }
  }

  Future<void> signIn({
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
    } on AuthException catch (e) {
      if (context.mounted) {
        showSnackbar(context, 'Erro no login: ${e.message}',
            type: SnackbarType.error);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackbar(context, 'Ocorreu um erro inesperado. Tente novamente.',
            type: SnackbarType.error);
      }
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
