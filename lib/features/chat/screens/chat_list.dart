import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/widgets/scaffold.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Chat List',
      body: Center(
        child: Text('Chat List Screen',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
    ;
  }
}
