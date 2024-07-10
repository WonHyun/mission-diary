import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/user_profile.dart';

class UserProfileViewModel extends AsyncNotifier<UserProfile> {
  @override
  FutureOr<UserProfile> build() {
    return const UserProfile(
      userId: "",
      userName: "",
      bio: "",
      profileImgPath: "",
    );
  }
}
