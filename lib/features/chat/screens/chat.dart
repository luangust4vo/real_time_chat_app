import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/chat/widgets/message_bubble.dart';
import 'package:real_time_chat_app/core/widgets/generic_scaffold.dart';
import 'package:real_time_chat_app/model/user.dart';
import 'package:real_time_chat_app/features/chat/services/chat_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();

  late final User _friend;
  late final int _friendshipId;
  late Future<List<Map<String, dynamic>>> _messagesFuture;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _friend = arguments['user'] as User;
      _friendshipId = arguments['friendship_id'] as int;

      _messagesFuture = _chatService.getMessages(_friendshipId);
      _chatService.markMessagesAsRead(_friendshipId);

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final content = _messageController.text.trim();
    _messageController.clear();

    await _chatService.sendMessage(
      friendshipId: _friendshipId,
      content: content,
    );

    setState(() {
      _messagesFuture = _chatService.getMessages(_friendshipId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = Supabase.instance.client.auth.currentUser!.id;

    return GenericScaffold(
      title: _friend.name,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _messagesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data ?? [];
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMine = message['sender_id'] == currentUserId;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Align(
                        alignment: isMine
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: MessageBubble(
                          content: message['content'],
                          isMine: isMine,
                          createdAt: DateTime.parse(message['created_at']),
                          isRead: message['is_read'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Material(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        color: Theme.of(context).cardColor,
        child: SafeArea(
          child: Row(
            children: [
              // ...
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Digite uma mensagem...',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send,
                    color: Theme.of(context).colorScheme.primary),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
