import 'package:flutter/material.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/widgets/home/widgets/mission_item.dart';

class TodayMissionListView extends StatelessWidget {
  const TodayMissionListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today Mission",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Gaps.v20,
        ListView.separated(
          padding: const EdgeInsets.only(bottom: Sizes.size96),
          shrinkWrap: true,
          primary: false,
          separatorBuilder: (context, index) => Gaps.v10,
          itemCount: 10,
          itemBuilder: (context, index) {
            return const MissionItem();
          },
        ),
      ],
    );
  }
}
