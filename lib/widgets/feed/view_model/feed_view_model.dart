import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/widgets/feed/repo/post_repository.dart';

class FeedViewModel extends AsyncNotifier<List<Post>> {
  late final PostRepository _repository;

  @override
  FutureOr<List<Post>> build() async {
    _repository = ref.read(postRepo);
    return await _repository.fetchPosts();
  }

  Future<void> refresh() async {
    if (state.value == null) return;
    state = await AsyncValue.guard(
      () async {
        return await _repository.fetchPosts(isRefresh: true);
      },
    );
  }

  Future<void> fetchNextPosts() async {
    if (state.value == null) return;
    state = await AsyncValue.guard(
      () async {
        final nextPosts = await _repository.fetchPosts();
        return [...state.value!, ...nextPosts];
      },
    );
  }

  Future<String?> reportPost(String postId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _repository.reportPost(postId);
        return [...state.value!.where((post) => post.postId != postId)];
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

  Future<String?> deletePost(String postId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _repository.deletePost(postId);
        return [...state.value!.where((post) => post.postId != postId)];
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

final feedProvider = AsyncNotifierProvider<FeedViewModel, List<Post>>(
  () => FeedViewModel(),
);
