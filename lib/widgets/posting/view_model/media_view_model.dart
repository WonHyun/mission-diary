import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/media_item.dart';
import 'package:mission_diary/widgets/home/view_model/mission_view_model.dart';

class MediaViewModel extends AutoDisposeAsyncNotifier<List<MediaItem>> {
  @override
  FutureOr<List<MediaItem>> build() {
    return _collectMediaItemFromMissions();
  }

  List<MediaItem> _collectMediaItemFromMissions() {
    final missions = ref.read(missionProvider).value!;
    return missions.expand((mission) => mission.mediaList).toList();
  }

  void selectAll(bool isSelected) {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.map((element) {
        return element.copyWith(isSelected: isSelected);
      }).toList(),
    );
  }

  void selectMedia(MediaItem media) {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.map((element) {
        if (element.mediaId == media.mediaId) {
          return element.copyWith(isSelected: !element.isSelected);
        } else {
          return element;
        }
      }).toList(),
    );
  }
}

final mediaProvider =
    AutoDisposeAsyncNotifierProvider<MediaViewModel, List<MediaItem>>(
  () => MediaViewModel(),
);
