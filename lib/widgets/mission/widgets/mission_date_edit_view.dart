import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/models/mission.dart';
import 'package:mission_diary/util/date_util.dart';
import 'package:mission_diary/widgets/mission/view_model/mission_edit_view_model.dart';

class MissionDateEditView extends ConsumerWidget {
  const MissionDateEditView({
    super.key,
    required this.mission,
  });

  final Mission mission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(missionEditProvider(mission.type));
    // final notifier = ref.read(missionEditProvider(mission.type).notifier);
    return state.value == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Start"),
                      Text(getYYYYMMDD(state.value!.startAt)),
                      Text(getHHMMapm(state.value!.startAt)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("End"),
                      Text(getYYYYMMDD(state.value!.endAt)),
                      Text(getHHMMapm(state.value!.endAt)),
                    ],
                  ),
                ],
              ),
              CheckboxListTile(
                title: const Text("All-Day Missions"),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size5,
                ),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                value: false,
                onChanged: (value) => {},
              ),
            ],
          );
  }
}
