import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/models/mission.dart';
import 'package:mission_diary/widgets/mission/view_model/mission_edit_view_model.dart';
import 'package:mission_diary/widgets/mission/widgets/selector_item.dart';

final List<Duration> durationList = [
  const Duration(minutes: 5),
  const Duration(minutes: 15),
  const Duration(minutes: 30),
  const Duration(minutes: 45),
  const Duration(minutes: 60),
];

class MissionDurationEditView extends ConsumerWidget {
  const MissionDurationEditView({
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
          "How Long Times",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Gaps.v16,
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            ...durationList.map(
              (duration) {
                final isSelected =
                    (state.value?.duration ?? durationList.first) == duration;
                return SelectorItem(
                  onTap: () => notifier.updateDuration(duration),
                  isSelected: isSelected,
                  text: "${duration.inMinutes}m",
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
