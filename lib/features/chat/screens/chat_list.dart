import 'package:flutter/material.dart';
import 'package:real_time_chat_app/app/routes.dart';
import 'package:real_time_chat_app/core/widgets/generic_scaffold.dart';
import 'package:real_time_chat_app/core/widgets/user_listview.dart';
import 'package:real_time_chat_app/features/auth/services/auth_service.dart';
import 'package:real_time_chat_app/model/user.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final List<User> users = [
    User(
        id: '1',
        name: 'Luan Gustavo',
        photoPath:
            'https://s2-valor.glbimg.com/dHPkcTVDv02aI9Dv6WSJ38oPZTE=/0x0:1200x780/888x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_63b422c2caee4269b8b34177e8876b93/internal_photos/bs/2024/9/O/5B4l1nTHipO9SlA2fS2g/dwayne-johnson-2014-cropped-.jpg'),
    User(
        id: '2',
        name: 'The Rock',
        photoPath:
            'https://s2-valor.glbimg.com/dHPkcTVDv02aI9Dv6WSJ38oPZTE=/0x0:1200x780/888x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_63b422c2caee4269b8b34177e8876b93/internal_photos/bs/2024/9/O/5B4l1nTHipO9SlA2fS2g/dwayne-johnson-2014-cropped-.jpg')
  ];

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      title: 'Conversas',
      actions: [
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
      body: Center(
        child: UserListView(
          items: users,
        ),
      ),
    );
  }
}
