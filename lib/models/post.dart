import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String postId,
    required String authorId,
    required String authorUserName,
    required String authorImgPath,
    required DateTime createdAt,
    required DateTime editAt,
    required String title,
    required String content,
    required int likes,
    required int commentCounts,
    required int score,
    required double satisfiedScore,
    required List<String> mediaUrlList,
    required List<String> commentsIdList,
    required List<String> missionsIdList,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
