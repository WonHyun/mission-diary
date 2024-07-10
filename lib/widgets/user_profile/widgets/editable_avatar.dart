import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mission_diary/models/user_profile.dart';
import 'package:mission_diary/widgets/user_profile/view_model/avatar_view_model.dart';

class EditableAvatar extends ConsumerWidget {
  const EditableAvatar({
    super.key,
    required this.profile,
    this.size = 36,
  });

  final UserProfile profile;
  final double size;

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 100,
      maxWidth: 100,
    );
    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ref.watch(avatarProvider).when(
            data: (_) {
              return GestureDetector(
                onTap: () => _onAvatarTap(ref),
                child: CircleAvatar(
                  foregroundImage: profile.profileImgPath.isEmpty
                      ? null
                      : NetworkImage(profile.profileImgPath),
                  radius: size,
                ),
              );
            },
            error: (err, stack) => Center(
              child: Text("error: $err"),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
    );
  }
}
