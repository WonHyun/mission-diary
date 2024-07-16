import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/models/mission.dart';
import 'package:mission_diary/util/date_util.dart';
import 'package:mission_diary/widgets/home/view_model/mission_list_view_model.dart';

class MissionItem extends ConsumerWidget {
  const MissionItem({
    super.key,
    required this.mission,
  });

  final Mission mission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => {},
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
              vertical: Sizes.size10,
            ),
            child: Row(
              children: [
                Checkbox(
                  value: mission.isCompleted,
                  onChanged: (value) =>
                      ref.read(missionListProvider.notifier).updateIsCompleted(
                            missionId: mission.missionId,
                            isCompleted: value!,
                          ),
                ),
                Gaps.h10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            mission.title,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          IconButton(
                            constraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            padding: const EdgeInsets.all(Sizes.size5),
                            iconSize: Sizes.size12,
                            color: Colors.grey.shade600,
                            onPressed: () => {},
                            icon: const Icon(FontAwesomeIcons.ellipsisVertical),
                          ),
                        ],
                      ),
                      Gaps.v5,
                      Text(
                        "${getHHMM(mission.startAt)} ~ ${getHHMM(mission.endAt)}",
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
