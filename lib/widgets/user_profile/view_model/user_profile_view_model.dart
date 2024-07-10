import 'dart:async';

import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/user_profile.dart';
import 'package:mission_diary/util/generate_util.dart';
import 'package:mission_diary/widgets/authentication/repo/authentication_repository.dart';
import 'package:mission_diary/widgets/user_profile/repo/user_profile_repository.dart';

class UserProfileViewModel extends AsyncNotifier<UserProfile> {
  late final UserProfileRepository _profileRepository;
  late final AuthenticationRepository _authRepository;

  UserProfile getEmptyUser() {
    return const UserProfile(
      userId: "",
      userName: "",
      email: "",
      bio: "",
      profileImgPath: "",
      createdAt: "",
    );
  }

  @override
  FutureOr<UserProfile> build() async {
    _profileRepository = ref.read(profileRepo);
    _authRepository = ref.read(authRepo);

    if (_authRepository.isLoggedIn) {
      final profile = await _profileRepository.findProfile(
        _authRepository.user!.uid,
      );
      if (profile != null) {
        return UserProfile.fromJson(profile);
      }
    }
    return getEmptyUser();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null || state.value == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final userProfile = AsyncData(
          state.value!.copyWith(
            userId: credential.user?.uid ?? "",
            email: credential.user?.email ?? "",
            profileImgPath: credential.user?.photoURL ?? "",
            userName:
                "${capitalizeFirst(faker.color.color())} ${capitalizeFirst(faker.animal.name())}",
            createdAt: DateTime.now().toIso8601String(),
          ),
        );
        await _profileRepository.createProfile(userProfile.value);
        return userProfile.value;
      },
    );
  }

  Future<void> fetchUserProfile() async {
    state = await AsyncValue.guard(
      () async {
        final profile = await _profileRepository.findProfile(
          _authRepository.user!.uid,
        );
        if (profile != null) {
          return UserProfile.fromJson(profile);
        } else {
          return getEmptyUser();
        }
      },
    );
  }

  Future<void> _updateUserProfileInfo(Map<String, dynamic> data) async {
    if (state.value == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _profileRepository.updateProfileInfo(state.value!.userId, data);
        final newUserProfile = UserProfile.fromJson(data);
        return state.value!.copyWith(
          userName: newUserProfile.userName,
          bio: newUserProfile.bio,
        );
      },
    );
  }

  Future<void> onAvatarUpload(String profileImgPath) async {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.copyWith(profileImgPath: profileImgPath),
    );
    await _profileRepository.updateProfileInfo(
      state.value!.userId,
      {"profileImgPath": profileImgPath},
    );
  }

  Future<void> editUserProfile({
    required String userName,
    required String bio,
  }) async {
    if (state.value == null) return;
    await _updateUserProfileInfo({
      "userName": userName,
      "bio": bio,
    });
  }

  void resetUserInfo() {
    state = AsyncData(getEmptyUser());
  }
}

final profileProvider =
    AsyncNotifierProvider<UserProfileViewModel, UserProfile>(
  () => UserProfileViewModel(),
);
