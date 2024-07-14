import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/media_item.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/util/calculate_util.dart';
import 'package:mission_diary/util/generate_util.dart';
import 'package:mission_diary/widgets/feed/view_model/feed_view_model.dart';
import 'package:mission_diary/widgets/home/view_model/home_view_model.dart';
import 'package:mission_diary/widgets/posting/repo/posting_repository.dart';
import 'package:mission_diary/widgets/user_profile/view_model/user_profile_view_model.dart';

class PostingViewModel extends AsyncNotifier<void> {
  late final PostingRepository _repository;

  Future<String?> completePosting({
    required String content,
    required List<MediaItem> selectedMedia,
  }) async {
    final user = ref.read(profileProvider).value;
    final missions = ref.read(missionListProvider).value;
    if (user == null || missions == null) {
      return "Have not user or mission info";
    }
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final newPost = Post(
          postId: uuid.v4(),
          authorId: user.userId,
          authorUserName: user.userName,
          authorImgPath: user.profileImgPath,
          createdAt: DateTime.now(),
          editAt: DateTime.now(),
          content: content,
          likes: 0,
          commentCounts: 0,
          score: calculateScore(missions),
          isReported: false,
          mediaUrlList: [],
          commentsIdList: [],
          missionStatusSummary: {
            for (var mission in missions) mission.title: mission.isCompleted
          },
        );
        await _repository.createPost(newPost, selectedMedia);
        await ref.read(feedProvider.notifier).refresh();
      },
    );
    if (state.hasError) {
      if (state.error != null && state.error is FirebaseException) {
        return (state.error as FirebaseException).message;
      } else {
        return "Unknown Exception during posting, please try later.";
      }
    }
    return null;
  }

  @override
  FutureOr<void> build() {
    _repository = ref.read(postingRepo);
  }
}

final postingProvider = AsyncNotifierProvider<PostingViewModel, void>(
  () => PostingViewModel(),
);
