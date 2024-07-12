import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/test/mock.dart';

class FeedViewModel extends AsyncNotifier<List<Post>> {
  @override
  FutureOr<List<Post>> build() {
    //TODO: will be fetch from firebase
    return PostMock.testPosts;
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> fetchNextPosts() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}

final feedProvider = AsyncNotifierProvider<FeedViewModel, List<Post>>(
  () => FeedViewModel(),
);
