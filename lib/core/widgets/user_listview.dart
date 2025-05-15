import 'package:flutter/material.dart';
import 'package:real_time_chat_app/model/user.dart';

class UserListView extends StatelessWidget {
  final List<User> items;

  const UserListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final user = items[index];

        return ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(user.photoPath)),
          title: Text(user.name),
          subtitle: Text(user.status ? 'Online' : 'Offline'),
        );
      },
    );
  }
}
