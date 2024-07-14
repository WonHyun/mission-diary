import 'package:flutter/material.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/widgets/common/safe_image.dart';

class PostMediaListView extends StatelessWidget {
  const PostMediaListView({
    super.key,
    required this.post,
    this.mediaWidth = 160,
    this.height = 150,
  });

  final Post post;
  final double mediaWidth;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => Gaps.h10,
        itemCount: post.mediaUrlList.length,
        itemBuilder: (context, index) {
          return Container(
            width: mediaWidth,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SafeImage(
              path: post.mediaUrlList[index],
              pathType: MediaPathType.url,
            ),
          );
        },
      ),
    );
  }
}
