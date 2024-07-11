import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/widgets/home/view_model/mission_view_model.dart';
import 'package:mission_diary/widgets/home/widgets/mission_item.dart';

class TodayMissionListView extends ConsumerWidget {
  const TodayMissionListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(missionProvider).when(
          data: (missions) {
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
                  itemCount: missions.length,
                  itemBuilder: (context, index) {
                    return MissionItem(
                      mission: missions[index],
                    );
                  },
                ),
              ],
            );
          },
          error: (err, stack) => Center(
            child: Text("error: $err"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
  }
}
