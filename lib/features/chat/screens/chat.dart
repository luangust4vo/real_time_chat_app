import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
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
  final TextEditingController _searchController = TextEditingController();

  late final User _friend;
  late final int _friendshipId;
  late final Stream<List<Map<String, dynamic>>> _messagesStream;
  bool _isInitialized = false;
  bool _isSearching = false;
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _friend = arguments['user'] as User;
      _friendshipId = arguments['friendship_id'] as int;

      _messagesStream = _chatService.getMessagesStream(_friendshipId);
      _chatService.markMessagesAsRead(_friendshipId);

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    _chatService.sendMessage(
      friendshipId: _friendshipId,
      content: _messageController.text.trim(),
    );
    _messageController.clear();
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }
    final results = await _chatService.searchMessages(
      friendshipId: _friendshipId,
      searchTerm: query,
    );
    setState(() => _searchResults = results);
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = Supabase.instance.client.auth.currentUser!.id;

    return GenericScaffold(
      title: _isSearching ? '' : _friend.name,
      subtitle: _isSearching ? null : 'Online',
      leading: _isSearching
          ? IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchResults = [];
                  _searchController.clear();
                });
              },
            )
          : null,
      titleWidget: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Pesquisar na conversa...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 18),
              onChanged: _performSearch,
            )
          : null,
      actions: _isSearching
          ? null
          : [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => setState(() => _isSearching = true),
              ),
            ],
      body: Column(
        children: [
          Expanded(
            child: _isSearching ? _buildSearchResults() : _buildMessagesList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchController.text.isEmpty) {
      return const Center(child: Text('Digite para pesquisar nas mensagens.'));
    }
    if (_searchResults.isEmpty) {
      return const Center(child: Text('Nenhuma mensagem encontrada.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final message = _searchResults[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text(message['content']),
            subtitle: Text(DateFormat('dd/MM/yyyy HH:mm')
                .format(DateTime.parse(message['created_at']))),
          ),
        );
      },
    );
  }

  Widget _buildMessagesList() {
    final currentUserId = Supabase.instance.client.auth.currentUser!.id;
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _messagesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final messages = snapshot.data ?? [];
        final hasUnreadMessages = messages.any((msg) =>
            msg['is_read'] == false && msg['sender_id'] != currentUserId);
        if (hasUnreadMessages) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _chatService.markMessagesAsRead(_friendshipId);
          });
        }
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
                  alignment:
                      isMine ? Alignment.centerRight : Alignment.centerLeft,
                  child: MessageBubble(
                    content: message['content'],
                    isMine: isMine,
                    createdAt: DateTime.parse(message['created_at']),
                    isRead: message['is_read'],
                  ),
                ),
              );
            });
      },
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
              IconButton(
                icon: Icon(Icons.attach_file,
                    color: Theme.of(context).textTheme.bodySmall?.color),
                onPressed: () {},
              ),
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
