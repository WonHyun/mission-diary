import 'dart:async';

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

  void onRemovePost(String postId) {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.where((post) => post.postId != postId).toList(),
    );
  }
}

final feedProvider = AsyncNotifierProvider<FeedViewModel, List<Post>>(
  () => FeedViewModel(),
);
