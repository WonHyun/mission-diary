import 'package:flutter/material.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/global/value.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/util/calculate_util.dart';
import 'package:mission_diary/util/date_util.dart';
import 'package:mission_diary/widgets/common/rank_icon.dart';

class PostSummaryView extends StatelessWidget {
  const PostSummaryView({
    super.key,
    required this.post,
    required this.onTap,
  });

  final Post post;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size10,
          vertical: Sizes.size10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: isDarkMode(context)
              ? null
              : [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(0, 5),
                    spreadRadius: 1,
                    blurRadius: 2,
                  ),
                ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getYYYYMMDD(post.createdAt),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.v5,
                  Text(
                    "Completed: ${post.missionStatusSummary.values.where((isCompleted) => isCompleted).length}/${post.missionStatusSummary.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size16,
                    ),
                  ),
                  Gaps.v5,
                  Text(
                    "Total Score: ${post.score.round()}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size16,
                    ),
                  ),
                ],
              ),
            ),
            Gaps.h5,
            RankIcon(rank: getRank(post.score)),
          ],
        ),
      ),
    );
  }
}
