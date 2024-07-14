import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';

class MissionEditScreen extends ConsumerStatefulWidget {
  const MissionEditScreen({super.key});

  static const String routePath = "/mission";
  static const String routeName = "mission";

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
            children: [
              AppBar(
                title: const Text("Edit Mission"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
