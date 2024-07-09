import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/widgets/authentication/repo/authentication_repository.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<String?> signUp(String email, String password) async {
    // final user = ref.read(userProvider.notifier);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final userCredential = await _authRepo.signUp(
          email,
          password,
        );
        // await user.createProfile(userCredential);
      },
    );
    if (state.hasError) {
      if (state.error != null && state.error is FirebaseException) {
        return (state.error as FirebaseException).message;
      } else {
        return "Unknown Exception during sign up, please try later.";
      }
    }
    return null;
  }
}

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
