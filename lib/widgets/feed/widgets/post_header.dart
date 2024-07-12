import 'package:flutter/material.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/util/date_util.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            post.authorUserName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Text(getTimeAgoFormat(post.createdAt)),
      ],
    );
  }
}
