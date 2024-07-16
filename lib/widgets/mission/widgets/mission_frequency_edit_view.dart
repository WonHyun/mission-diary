import 'package:flutter/material.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/global/sizes.dart';

class MissionFrequencyEditView extends StatelessWidget {
  const MissionFrequencyEditView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("How Often?"),
        Row(
          children: [
            ...MissionFrequency.values.map(
              (value) => Container(
                padding: const EdgeInsets.all(
                  Sizes.size5,
                ),
                child: Text(value.name),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
