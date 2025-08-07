import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardService {
  final _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> fetchUserStats() async {
    try {
      final stats = await _supabase.rpc('get_user_stats').single();
      return stats;
    } catch (e) {
      print('Erro ao buscar estatísticas: $e');
      return {'total_friends': 0, 'total_messages_sent': 0};
    }
  }
}
