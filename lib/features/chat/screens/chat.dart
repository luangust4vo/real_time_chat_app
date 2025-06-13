import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/widgets/generic_scaffold.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      title: 'Chat',
      body: Center(
        child: Text('Chat Screen',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
