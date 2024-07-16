import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/models/mission.dart';
import 'package:mission_diary/widgets/mission/view_model/mission_edit_view_model.dart';

class MissionSettingEditView extends ConsumerWidget {
  const MissionSettingEditView({
    super.key,
    required this.mission,
  });

  final Mission mission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(missionEditProvider(mission.type));
    final notifier = ref.read(missionEditProvider(mission.type).notifier);
    return state.value == null
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mission Settings",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Gaps.v10,
              CheckboxListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size5,
                ),
                title: const Text("Need a Proof Photos"),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                value: state.value?.isNeedPhoto ?? false,
                onChanged: (value) =>
                    notifier.updateIsNeedPhoto(value ?? false),
              ),
              CheckboxListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size5,
                ),
                title: const Text("Private Missions"),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                value: state.value?.isPrivate ?? false,
                onChanged: (value) => notifier.updateIsPrivate(value ?? false),
              ),
            ],
          );
  }
}
