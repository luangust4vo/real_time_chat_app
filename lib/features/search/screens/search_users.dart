import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/widgets/generic_scaffold.dart';
import 'package:real_time_chat_app/services/friends_service.dart';

class SearchUsers extends StatefulWidget {
  const SearchUsers({super.key});

  @override
  State<SearchUsers> createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  final _friendsService = FriendsService();
  final _searchController = TextEditingController();

  List<Map<String, dynamic>> _foundUsers = [];
  final Set<String> _pendingRequests = {};
  bool _isLoading = false;

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _foundUsers = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final users = await _friendsService.searchUsers(query);
    setState(() {
      _foundUsers = users;
      _isLoading = false;
    });
  }

  Future<void> _addFriend(String userId, String userName) async {
    final success = await _friendsService.sendFriendRequest(userId);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Solicitação de amizade enviada para $userName!'),
          backgroundColor: Colors.green, // Sucesso
        ),
      );

      setState(() {
        _pendingRequests.add(userId);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Erro ao enviar solicitação. Tente novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      title: 'Adicionar Amigos',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Digite o nome...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _performSearch,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _foundUsers.isEmpty
                      ? const Center(
                          child: Text('Nenhum usuário encontrado.'),
                        )
                      : ListView.builder(
                          itemCount: _foundUsers.length,
                          itemBuilder: (context, index) {
                            final user = _foundUsers[index];
                            final bool isPending =
                                _pendingRequests.contains(user['id']);

                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text(user['name'][0].toUpperCase()),
                                ),
                                title: Text(user['name']),
                                trailing: IconButton(
                                    icon: const Icon(
                                        Icons.person_add_alt_1_outlined),
                                    onPressed: isPending
                                        ? null
                                        : () => _addFriend(
                                            user['id'], user['name'])),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
