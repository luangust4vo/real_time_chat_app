import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProfileService {
  final _supabase = Supabase.instance.client;

  Future<void> uploadAvatar() async {
    try {
      final picker = ImagePicker();
      final imageFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 300,
        maxHeight: 300,
      );

      if (imageFile == null) return;
      final currentUser = _supabase.auth.currentUser;
      if (currentUser == null) return;

      final fileExtension = imageFile.path.split('.').last.toLowerCase();
      final filePath = '${currentUser.id}/avatar.$fileExtension';

      if (kIsWeb) {
        final imageBytes = await imageFile.readAsBytes();
        await _supabase.storage.from('images').uploadBinary(
              filePath,
              imageBytes,
              fileOptions:
                  const FileOptions(cacheControl: '3600', upsert: true),
            );
      } else {
        await _supabase.storage.from('images').upload(
              filePath,
              File(imageFile.path),
              fileOptions:
                  const FileOptions(cacheControl: '3600', upsert: true),
            );
      }

      final imageUrl = _supabase.storage.from('images').getPublicUrl(filePath);

      await _supabase.from('profiles').update({
        'photo_url': imageUrl,
      }).eq('id', currentUser.id);
    } catch (e) {
      print('Erro ao fazer upload do avatar: $e');
    }
  }

  Future<void> updateName(String newName) async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null || newName.trim().isEmpty) return;

    await _supabase.from('profiles').update({
      'name': newName.trim(),
    }).eq('id', currentUser.id);
  }
}
