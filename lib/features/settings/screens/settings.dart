import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat_app/core/widgets/generic_scaffold.dart';
import 'package:real_time_chat_app/providers/theme_provider.dart';
import 'package:real_time_chat_app/features/settings/services/profile_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final ProfileService _profileService = ProfileService();
  final _nameController = TextEditingController();
  String? _avatarUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    final userId = Supabase.instance.client.auth.currentUser!.id;
    try {
      final profile = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      _nameController.text = profile['name'] ?? '';
      _avatarUrl = profile['photo_url'];
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar perfil: $e')),
        );
      }
    }
    setState(() => _isLoading = false);
  }

  Future<void> _updateProfile() async {
    await _profileService.updateName(_nameController.text);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nome atualizado com sucesso!')),
      );
      FocusScope.of(context).unfocus();
    }
  }

  Future<void> _uploadAvatar() async {
    await _profileService.uploadAvatar();
    await _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return GenericScaffold(
          title: 'Definições',
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Text('Perfil',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 20),
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              backgroundImage: _avatarUrl != null
                                  ? NetworkImage(_avatarUrl!)
                                  : null,
                              child: _avatarUrl == null
                                  ? const Icon(Icons.person, size: 60)
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton.filled(
                                onPressed: _uploadAvatar,
                                icon: const Icon(Icons.edit),
                                tooltip: 'Alterar foto',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Nome'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _updateProfile,
                        child: const Text('Guardar Alterações'),
                      ),
                      const Divider(height: 40),
                      Text('Tema da Aplicação',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 16),
                      SegmentedButton<ThemeMode>(
                        segments: const [
                          ButtonSegment(
                            value: ThemeMode.light,
                            label: Text('Claro'),
                            icon: Icon(Icons.wb_sunny_outlined),
                          ),
                          ButtonSegment(
                            value: ThemeMode.dark,
                            label: Text('Escuro'),
                            icon: Icon(Icons.nightlight_outlined),
                          ),
                          ButtonSegment(
                            value: ThemeMode.system,
                            label: Text('Sistema'),
                            icon: Icon(Icons.smartphone_outlined),
                          ),
                        ],
                        selected: {themeProvider.themeMode},
                        onSelectionChanged: (newSelection) {
                          themeProvider.setTheme(newSelection.first);
                        },
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
