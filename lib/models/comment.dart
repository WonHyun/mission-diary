import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    required String commentId,
    required String postId,
    required String authorId,
    required String authorUserName,
    required String authorImgPath,
    required DateTime createdAt,
    required DateTime editAt,
    required String content,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
