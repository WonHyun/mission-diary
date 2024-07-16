import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/models/mission.dart';
import 'package:mission_diary/widgets/mission/view_model/mission_edit_view_model.dart';
import 'package:mission_diary/widgets/mission/widgets/selector_item.dart';

class MissionFrequencyEditView extends ConsumerWidget {
  const MissionFrequencyEditView({
    super.key,
    required this.mission,
  });

  final Mission mission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(missionEditProvider(mission.type));
    final notifier = ref.read(missionEditProvider(mission.type).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "How Often",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Gaps.v16,
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            ...MissionFrequency.values.map(
              (value) {
                final isSelected =
                    (state.value?.frequency ?? MissionFrequency.once) == value;
                return SelectorItem(
                  onTap: () => notifier.updateFrequency(value),
                  isSelected: isSelected,
                  text: value.name,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
