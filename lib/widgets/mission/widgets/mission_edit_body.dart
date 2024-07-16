import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/models/mission.dart';
import 'package:mission_diary/widgets/common/rounded_button.dart';
import 'package:mission_diary/widgets/home/home_screen.dart';
import 'package:mission_diary/widgets/mission/view_model/mission_edit_view_model.dart';
import 'package:mission_diary/widgets/mission/widgets/mission_date_edit_view.dart';
import 'package:mission_diary/widgets/mission/widgets/mission_duration_edit_view.dart';
import 'package:mission_diary/widgets/mission/widgets/mission_frequency_edit_view.dart';
import 'package:mission_diary/widgets/mission/widgets/mission_setting_edit_view.dart';
import 'package:mission_diary/widgets/mission/widgets/mission_type_list_item.dart';

class MissionEditBody extends ConsumerStatefulWidget {
  const MissionEditBody({
    super.key,
    required this.mission,
    this.isEditView = false,
  });

  final Mission mission;
  final bool isEditView;

  @override
  ConsumerState<MissionEditBody> createState() => _MissionEditBodyState();
}

class _MissionEditBodyState extends ConsumerState<MissionEditBody> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _onTapCreate() async {
    final result = await ref
        .read(missionEditProvider(widget.mission.type).notifier)
        .createNewMission();
    if (result != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          content: Text(result),
        ),
      );
    } else {
      if (mounted) {
        context.goNamed(HomeScreen.routeName);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(missionEditProvider(widget.mission.type));
    final notifier =
        ref.read(missionEditProvider(widget.mission.type).notifier);
    final mission = widget.mission;
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.isEditView
                      ? MissionTypeListItem(type: mission.type)
                      : Hero(
                          tag: mission.type.name,
                          child: MissionTypeListItem(type: mission.type),
                        ),
                  Gaps.v32,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      TextField(
                        controller: _titleController,
                        onChanged: notifier.updateTitle,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10),
                          labelText: "Mission Title",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                      Gaps.v28,
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      TextField(
                        minLines: 1,
                        maxLines: 5,
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10),
                          labelText: "What you do?",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                      Gaps.v28,
                      MissionDateEditView(mission: mission),
                      Gaps.v28,
                      MissionDurationEditView(mission: mission),
                      Gaps.v28,
                      MissionFrequencyEditView(mission: mission),
                      Gaps.v28,
                      MissionSettingEditView(mission: mission),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: RoundedButton(
            onTap: _onTapCreate,
            text: "Create",
            fontColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primary,
            isActive: mission.title.isNotEmpty && !state.isLoading,
          ),
        ),
      ],
    );
  }
}
