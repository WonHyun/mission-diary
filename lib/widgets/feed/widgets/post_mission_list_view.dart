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
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      separatorBuilder: (context, index) => Gaps.v5,
      itemCount: missionList.length,
      itemBuilder: (context, index) {
        return PostMissionListItem(
          title: missionList[index],
          isCompleted: missionStatus[missionList[index]] ?? false,
        );
      },
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
      child: Row(
        children: [
          Checkbox(
            value: isCompleted,
            onChanged: (value) => {},
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
