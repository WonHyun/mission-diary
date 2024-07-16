import 'package:flutter/material.dart';
import 'package:mission_diary/global/color.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';

class PostMissionListView extends StatelessWidget {
  const PostMissionListView({
    super.key,
    required this.missionList,
    required this.missionStatus,
  });

  final List<String> missionList;
  final Map<String, bool> missionStatus;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          ...missionList.map(
            (mission) {
              return PostMissionListItem(
                title: mission,
                isCompleted: missionStatus[mission] ?? false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class PostMissionListItem extends StatelessWidget {
  const PostMissionListItem({
    super.key,
    required this.title,
    required this.isCompleted,
  });

  final String title;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size5,
        vertical: Sizes.size5,
      ),
      decoration: BoxDecoration(
        color: isCompleted
            ? Theme.of(context).colorScheme.secondary
            : ThemeColors.lightCoral,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Checkbox(
            fillColor: WidgetStateProperty.resolveWith(
              (states) {
                if (!states.contains(WidgetState.selected)) {
                  return Colors.transparent;
                }
                return Theme.of(context).colorScheme.primary;
              },
            ),
            value: isCompleted,
            onChanged: null,
          ),
          Gaps.h5,
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
