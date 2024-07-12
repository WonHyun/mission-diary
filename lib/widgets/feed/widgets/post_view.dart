import 'package:flutter/material.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/global/value.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/util/calculate_util.dart';
import 'package:mission_diary/util/date_util.dart';
import 'package:mission_diary/widgets/common/rank_icon.dart';
import 'package:mission_diary/widgets/common/satisfied_emoji.dart';
import 'package:mission_diary/widgets/feed/widgets/post_media_list_view.dart';
import 'package:mission_diary/widgets/feed/widgets/post_mission_list_view.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.post.authorUserName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(getTimeAgoFormat(widget.post.createdAt)),
                ],
              ),
              Gaps.v5,
              GestureDetector(
                onTap: () => setState(() {
                  _isExpaneded = !_isExpaneded;
                }),
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
                              getYYYYMMDD(widget.post.createdAt),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Gaps.v5,
                            Text(
                              "Completed: ${widget.post.missionStatusSummary.values.where((isCompleted) => isCompleted).length}/${widget.post.missionStatusSummary.length}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Gaps.v5,
                            Text(
                              "Score: ${widget.post.score.round()}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.h5,
                      RankIcon(rank: getRank(widget.post.score)),
                      Gaps.h5,
                      SatisfiedEmoji(
                        satisfiedScore: widget.post.satisfiedScore,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                clipBehavior: Clip.hardEdge,
                height: _isExpaneded ? 500 : 0,
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
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
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
                        ),
                      ),
                      Gaps.v10,
                      PostMissionListView(
                        missionList:
                            widget.post.missionStatusSummary.keys.toList(),
                        missionStatus: widget.post.missionStatusSummary,
                      ),
                      Gaps.v10,
                      Text(
                        widget.post.content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Gaps.v10,
                      if (widget.post.mediaUrlList.isNotEmpty)
                        PostMediaListView(post: widget.post),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
