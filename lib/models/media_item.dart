import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mission_diary/global/enum.dart';

part 'media_item.freezed.dart';
part 'media_item.g.dart';

@freezed
class MediaItem with _$MediaItem {
  const factory MediaItem({
    required String mediaId,
    required MediaType mediaType,
    required MediaPathType mediaPathType,
    required String path,
    required Map<String, dynamic> metadata,
    required bool isSelected,
  }) = _MediaItem;

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);
}
