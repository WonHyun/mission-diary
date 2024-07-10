import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/widgets/authentication/repo/authentication_repository.dart';
import 'package:mission_diary/widgets/user_profile/repo/user_profile_repository.dart';
import 'package:mission_diary/widgets/user_profile/view_model/user_profile_view_model.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserProfileRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(profileRepo);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async {
        final url = await _repository.uploadAvatar(file, fileName);
        await ref.read(profileProvider.notifier).onAvatarUpload(url);
      },
    );
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
