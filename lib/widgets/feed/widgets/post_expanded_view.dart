import 'package:flutter/material.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/widgets/feed/widgets/post_media_list_view.dart';
import 'package:mission_diary/widgets/feed/widgets/post_mission_list_view.dart';
import 'package:mission_diary/widgets/posting/widgets/emoji_slider.dart';

class PostExpandedView extends StatelessWidget {
  const PostExpandedView({
    super.key,
    required this.isExpaneded,
    required this.post,
  });

  final bool isExpaneded;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      height: isExpaneded ? 500 : 0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size10,
        vertical: Sizes.size10,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: Sizes.size10,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Missions Status",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            EmojiSlider(
              score: post.score,
              height: 100,
            ),
            Gaps.v10,
            PostMissionListView(
              missionList: post.missionStatusSummary.keys.toList(),
              missionStatus: post.missionStatusSummary,
            ),
            Gaps.v10,
            Text(
              post.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Gaps.v10,
            if (post.mediaUrlList.isNotEmpty) PostMediaListView(post: post),
          ],
        ),
      ),
    );
  }
}
