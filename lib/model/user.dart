class User {
  final String id;
  final String name;
  final String? photoPath;
  final String? lastMessage;
  final bool? status;

  User(
      {required this.id,
      required this.name,
      this.photoPath,
      this.lastMessage,
      this.status});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['user_id'],
      name: map['user_name'] ?? 'Nome Indisponível',
      photoPath: map['user_photo_url'],
      status: map['status'] ?? false,
    );
  }
}
