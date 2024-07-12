import 'package:flutter/material.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/global/value.dart';

class PostUserAvatar extends StatelessWidget {
  const PostUserAvatar({
    super.key,
    required this.imgPath,
    this.size = 20,
  });

  final String imgPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Sizes.size5,
        top: Sizes.size5,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: BoxShape.circle,
        boxShadow: isDarkMode(context)
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0, 3),
                  blurRadius: 3,
                  spreadRadius: 1,
                ),
              ],
      ),
      child: CircleAvatar(
        radius: size,
        foregroundImage: imgPath.isEmpty ? null : NetworkImage(imgPath),
      ),
    );
  }
}
