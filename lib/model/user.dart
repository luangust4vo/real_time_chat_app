class User {
  final String id;
  final String name;
  final String? photoPath;
  final bool? status;
  final String? lastMessage;
  final String? lastMessageSenderId;
  final int unreadMessageCount;

  User({
    required this.id,
    required this.name,
    this.photoPath,
    this.status,
    this.lastMessage,
    this.lastMessageSenderId,
    this.unreadMessageCount = 0,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['user_id'],
      name: map['user_name'] ?? 'Nome Indisponível',
      photoPath: map['user_photo_url'],
      lastMessage: map['last_message_content'],
      lastMessageSenderId: map['last_message_sender_id'],
      unreadMessageCount: map['unread_message_count'] ?? 0,
    );
  }
}
