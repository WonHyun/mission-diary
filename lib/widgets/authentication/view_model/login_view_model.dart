import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/widgets/authentication/repo/authentication_repository.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<String?> loginWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _authRepo.login(email, password);
        // ref.read(userProvider.notifier).fetchUserProfile();
      },
    );
    if (state.hasError) {
      if (state.error != null && state.error is FirebaseException) {
        return (state.error as FirebaseException).message;
      } else {
        return "Unknown Exception during login, please try later.";
      }
    }
    return null;
  }

  Future<String?> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _authRepo.logout();
        // ref.read(userProvider.notifier).resetUserInfo();
      },
    );
    if (state.hasError) {
      if (state.error != null && state.error is FirebaseException) {
        return (state.error as FirebaseException).message;
      } else {
        return "Unknown Exception during logout, please try later.";
      }
    }
    return null;
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
