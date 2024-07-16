import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';

class MissionEditScreen extends ConsumerStatefulWidget {
  const MissionEditScreen({super.key});

  static const String routePath = "/mission-edit";
  static const String routeName = "mission-edit";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MissionEditScreenState();
}

class _MissionEditScreenState extends ConsumerState<MissionEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstraintedBody(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                title: Text(
                  "Edit Mission",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Text("Title"),
              const Text("Date"),
              const Text("Time"),
              const Text("Description"),
            ],
          ),
        ),
      ),
    );
  }
}
