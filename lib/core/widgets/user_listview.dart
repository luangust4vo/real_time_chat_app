import 'package:flutter/material.dart';
import 'package:real_time_chat_app/model/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class UserListView extends StatelessWidget {
  final List<User> items;
  final List<Map<String, dynamic>> fullData;

  const UserListView({super.key, required this.items, required this.fullData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final user = items[index];
        final currentUserId = Supabase.instance.client.auth.currentUser!.id;

        String subtitleText = user.lastMessage ?? 'Inicie a conversa!';
        if (user.lastMessageSenderId == currentUserId) {
          subtitleText = 'Você: $subtitleText';
        }

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            backgroundImage:
                user.photoPath != null ? NetworkImage(user.photoPath!) : null,
            child: user.photoPath == null
                ? Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  )
                : null,
          ),
          title: Text(user.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
            subtitleText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: user.unreadMessageCount > 0
              ? CircleAvatar(
                  radius: 12,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    user.unreadMessageCount.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : null,
          onTap: () {
            final friendshipId = fullData[index]['friendship_id'];

            Navigator.pushNamed(
              context,
              '/chat',
              arguments: {
                'user': user,
                'friendship_id': friendshipId,
              },
            );
          },
        );
      },
    );
  }
}
