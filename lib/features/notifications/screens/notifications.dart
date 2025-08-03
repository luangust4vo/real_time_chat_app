import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/widgets/generic_scaffold.dart';
import 'package:real_time_chat_app/services/friends_service.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final _friendsService = FriendsService();
  late Future<List<Map<String, dynamic>>> _requestsFuture;

  @override
  void initState() {
    super.initState();
    _requestsFuture = _friendsService.getPendingRequests();
  }

  void _handleRequest(String requesterId, String status, int index) {
    _friendsService.updateRequestStatus(
        requesterId: requesterId, status: status);

    setState(() {
      _requestsFuture = _friendsService.getPendingRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      title: 'Notificações',
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _requestsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
                child: Text('Ocorreu um erro ao buscar as notificações.'));
          }

          final requests = snapshot.data ?? [];
          if (requests.isEmpty) {
            return const Center(child: Text('Nenhuma notificação.'));
          }

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              final requesterProfile =
                  request['requester'] as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Text(requesterProfile['name'][0].toUpperCase()),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          '${requesterProfile['name']} quer ser seu amigo.',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.check_circle_outline,
                            color: Colors.green),
                        onPressed: () => _handleRequest(
                            requesterProfile['id'], 'accepted', index),
                        tooltip: 'Aceitar',
                      ),
                      // Botão de Recusar
                      IconButton(
                        icon:
                            const Icon(Icons.highlight_off, color: Colors.red),
                        onPressed: () => _handleRequest(
                            requesterProfile['id'], 'declined', index),
                        tooltip: 'Recusar',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
