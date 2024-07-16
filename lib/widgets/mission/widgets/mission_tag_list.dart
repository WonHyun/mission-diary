import 'package:flutter/material.dart';
import 'package:mission_diary/global/gaps.dart';

class MissionTagList extends StatelessWidget {
  const MissionTagList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Tag"),
        Gaps.v20,
      ],
    );
  }
}
