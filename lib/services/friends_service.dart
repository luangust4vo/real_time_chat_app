import 'package:real_time_chat_app/model/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class FriendsService {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> searchUsers(String nameQuery) async {
    if (nameQuery.isEmpty) {
      return [];
    }

    try {
      final String currentUserId = _supabase.auth.currentUser!.id;

      final response = await _supabase
          .from('profiles')
          .select()
          .ilike('name', '%$nameQuery%')
          .neq('id', currentUserId)
          .limit(30);

      return response;
    } catch (e) {
      return [];
    }
  }

  Future<bool> sendFriendRequest(String addresseeId) async {
    try {
      final String requesterId = _supabase.auth.currentUser!.id;

      await _supabase.from('friendships').insert({
        'requester_id': requesterId,
        'addressee_id': addresseeId,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getPendingRequests() async {
    try {
      final userId = _supabase.auth.currentUser!.id;
      final response = await _supabase
          .from('friendships')
          .select('*, requester:profiles!requester_id(*)')
          .eq('addressee_id', userId)
          .eq('status', 'pending');

      return response;
    } catch (e) {
      return [];
    }
  }

  Future<void> updateRequestStatus({
    required String requesterId,
    required String status,
  }) async {
    try {
      final userId = _supabase.auth.currentUser!.id;
      await _supabase
          .from('friendships')
          .update({'status': status})
          .eq('requester_id', requesterId)
          .eq('addressee_id', userId);
    } catch (e) {
      print('Erro ao atualizar status da amizade: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> getFriendRequestStream() {
    final userId = _supabase.auth.currentUser!.id;

    return _supabase
        .from('friendships')
        .stream(primaryKey: ['id'])
        .eq('addressee_id', userId)
        .map((listOfFriendships) {
          return listOfFriendships
              .where((friendship) => friendship['status'] == 'pending')
              .toList();
        });
  }

  Stream<List<User>> getFriendsStream() {
    return _supabase.from('friendships').stream(primaryKey: ['id']).map((_) {
      return _supabase.rpc('get_friends');
    }).asyncMap((future) async {
      final friendsData = await future;

      final friendsList = (friendsData as List)
          .map((friendMap) => User.fromMap(friendMap))
          .toList();

      return friendsList;
    });
  }
}
