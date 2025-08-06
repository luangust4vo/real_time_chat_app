import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getMessages(int friendshipId) async {
    try {
      final response = await _supabase
          .from('messages')
          .select()
          .eq('friendship_id', friendshipId)
          .order('created_at', ascending: false); // As mais recentes primeiro
      return response;
    } catch (e) {
      return [];
    }
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
}
