import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/widgets/generic_scaffold.dart';
import 'package:real_time_chat_app/core/widgets/user_listview.dart';
import 'package:real_time_chat_app/model/user.dart';

class ChatList extends StatefulWidget {
  final List<User> users = [
    User(
        name: 'Luan Gustavo',
        email: 'luan@gmail.com',
        dateOfBirth: DateTime(2004, 1, 16),
        status: true,
        photoPath:
            'https://s2-valor.glbimg.com/dHPkcTVDv02aI9Dv6WSJ38oPZTE=/0x0:1200x780/888x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_63b422c2caee4269b8b34177e8876b93/internal_photos/bs/2024/9/O/5B4l1nTHipO9SlA2fS2g/dwayne-johnson-2014-cropped-.jpg'),
    User(
        name: 'Luan Gustavo',
        email: 'luan@gmail.com',
        dateOfBirth: DateTime(2004, 1, 16),
        status: true,
        photoPath:
            'https://s2-valor.glbimg.com/dHPkcTVDv02aI9Dv6WSJ38oPZTE=/0x0:1200x780/888x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_63b422c2caee4269b8b34177e8876b93/internal_photos/bs/2024/9/O/5B4l1nTHipO9SlA2fS2g/dwayne-johnson-2014-cropped-.jpg')
  ];

  ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      title: 'Chat List',
      body: Center(
        child: UserListView(
          items: widget.users,
        ),
      ),
    );
  }
}
