import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';
import 'package:mission_diary/widgets/mission/view_model/mission_edit_view_model.dart';
import 'package:mission_diary/widgets/mission/widgets/mission_edit_body.dart';

class MissionAddScreen extends ConsumerWidget {
  const MissionAddScreen({
    super.key,
    required this.type,
  });

  static const String routePath = "/mission-add";
  static const String routeName = "mission-add";

  final MissionType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Mission",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: ConstraintedBody(
        alignment: Alignment.topCenter,
        child: ref.watch(missionEditProvider(type)).when(
              data: (mission) {
                return MissionEditBody(mission: mission);
              },
              error: (err, stack) => Center(
                child: Text("error: $err"),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
      ),
    );
  }
}
