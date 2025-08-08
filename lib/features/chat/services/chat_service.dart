import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService {
  final _supabase = Supabase.instance.client;

  Stream<List<Map<String, dynamic>>> getMessagesStream(int friendshipId) {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('friendship_id', friendshipId)
        .order('created_at', ascending: false)
        .map((data) => data);
  }

  Future<void> sendMessage({
    required int friendshipId,
    required String content,
  }) async {
    if (content.isEmpty) return;

    final senderId = _supabase.auth.currentUser!.id;

    await _supabase.from('messages').insert({
      'friendship_id': friendshipId,
      'sender_id': senderId,
      'content': content,
    });
  }

  Future<void> markMessagesAsRead(int friendshipId) async {
    final currentUserId = _supabase.auth.currentUser!.id;
    await _supabase
        .from('messages')
        .update({'is_read': true})
        .eq('friendship_id', friendshipId)
        .neq('sender_id', currentUserId);
  }

  Future<List<Map<String, dynamic>>> searchMessages({
    required int friendshipId,
    required String searchTerm,
  }) async {
    try {
      final response =
          await _supabase.rpc('search_messages_in_conversation', params: {
        'p_friendship_id': friendshipId,
        'p_search_term': searchTerm,
      });
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      print('Erro ao procurar mensagens: $e');
      return [];
    }
  }
}
