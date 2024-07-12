import 'package:flutter/material.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/models/post.dart';

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
            child: Image.network(
              post.mediaUrlList[index],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported_rounded),
            ),
          );
        },
      ),
    );
  }
}
