import 'package:flutter/material.dart';
import 'package:real_time_chat_app/app/routes.dart';
import 'package:real_time_chat_app/core/widgets/generic_scaffold.dart';
import 'package:real_time_chat_app/core/widgets/user_listview.dart';
import 'package:real_time_chat_app/features/auth/services/auth_service.dart';
import 'package:real_time_chat_app/model/user.dart';
import 'package:real_time_chat_app/services/friends_service.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final authService = AuthService();
  final _friendsService = FriendsService();

  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      title: 'Conversas',
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.search_users);
          },
          tooltip: 'Buscar usuários',
        ),
        StreamBuilder<List<Map<String, dynamic>>>(
          stream: _friendsService.getFriendRequestStream(),
          builder: (context, snapshot) {
            final requestCount = snapshot.data?.length ?? 0;

            return Badge(
              isLabelVisible: requestCount > 0,
              label: Text(requestCount.toString()),
              alignment: AlignmentDirectional.topEnd,
              offset: const Offset(-2, 2),
              child: IconButton(
                icon: const Icon(Icons.notifications_none_outlined),
                onPressed: () async {
                  await Navigator.of(context).pushNamed(Routes.notifications);

                  if (mounted) {
                    setState(() {});
                  }
                },
                tooltip: 'Notificações',
              ),
            );
          },
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            if (value == 'settings') {
              Navigator.of(context).pushNamed(Routes.settings);
            } else if (value == 'logout') {
              authService.signOut(context);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'settings',
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configurações'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'logout',
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('Sair', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ],
      body: StreamBuilder<List<User>>(
        stream: _friendsService.getFriendsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Ocorreu um erro: ${snapshot.error}'));
          }

          final friends = snapshot.data ?? [];

          if (friends.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'Você ainda não tem amigos. Use a lupa para procurar e adicionar novos amigos!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }

          return UserListView(items: friends);
        },
      ),
    );
  }
}
