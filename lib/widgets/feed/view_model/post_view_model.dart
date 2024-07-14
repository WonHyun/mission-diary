import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/widgets/feed/repo/post_repository.dart';
import 'package:mission_diary/widgets/feed/view_model/feed_view_model.dart';

class PostViewModel extends FamilyAsyncNotifier<void, String> {
  late final PostRepository _repository;

  late String _postId;

  @override
  FutureOr<void> build(String arg) async {
    _repository = ref.read(postRepo);
    _postId = arg;
  }

  Future<String?> reportPost() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _repository.reportPost(_postId);
        ref.read(feedProvider.notifier).onRemovePost(_postId);
      },
    );
    if (state.hasError) {
      if (state.error != null && state.error is FirebaseException) {
        return (state.error as FirebaseException).message;
      } else {
        return "Unknown Exception during report, please try later.";
      }
    }
    return null;
  }

  Future<String?> deletePost() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _repository.deletePost(_postId);
        ref.read(feedProvider.notifier).onRemovePost(_postId);
      },
    );
    if (state.hasError) {
      if (state.error != null && state.error is FirebaseException) {
        return (state.error as FirebaseException).message;
      } else {
        return "Unknown Exception during delete, please try later.";
      }
    }
    return null;
  }
}

final postProvider = AsyncNotifierProvider.family<PostViewModel, void, String>(
  () => PostViewModel(),
);
