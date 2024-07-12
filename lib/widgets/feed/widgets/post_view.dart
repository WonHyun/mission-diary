import 'package:flutter/material.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/widgets/feed/widgets/post_expanded_view.dart';
import 'package:mission_diary/widgets/feed/widgets/post_header.dart';
import 'package:mission_diary/widgets/feed/widgets/post_summary_view.dart';
import 'package:mission_diary/widgets/feed/widgets/post_user_avatar.dart';

class PostView extends StatefulWidget {
  const PostView({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  bool _isExpaneded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostUserAvatar(imgPath: widget.post.authorImgPath),
        Gaps.h12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostHeader(post: widget.post),
              Gaps.v5,
              PostSummaryView(
                post: widget.post,
                onTap: () => setState(() {
                  _isExpaneded = !_isExpaneded;
                }),
              ),
              PostExpandedView(
                isExpaneded: _isExpaneded,
                post: widget.post,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
