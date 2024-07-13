import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/media_item.dart';
import 'package:mission_diary/widgets/home/view_model/mission_view_model.dart';

class MediaViewModel extends AsyncNotifier<List<MediaItem>> {
  @override
  FutureOr<List<MediaItem>> build() {
    return collectMediaItemFromMissions();
  }

  List<MediaItem> collectMediaItemFromMissions() {
    final missions = ref.read(missionProvider).value!;
    return missions.expand((mission) => mission.mediaList).toList();
  }

  Future<void> deleteMedia(MediaItem media) async {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.where((media) => media.mediaId == media.mediaId).toList(),
    );
  }
}

final mediaProvider = AsyncNotifierProvider<MediaViewModel, List<MediaItem>>(
  () => MediaViewModel(),
);
