import 'package:flutter/material.dart';

final List<Duration> durationList = [
  const Duration(minutes: 15),
  const Duration(minutes: 30),
  const Duration(minutes: 45),
  const Duration(minutes: 60),
  const Duration(minutes: 90),
];

class MissionDurationEditView extends StatelessWidget {
  const MissionDurationEditView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("How Long Times?"),
      ],
    );
  }
}
