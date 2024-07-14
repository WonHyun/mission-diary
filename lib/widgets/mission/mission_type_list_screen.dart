import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';
import 'package:mission_diary/widgets/mission/mission_add_screen.dart';
import 'package:mission_diary/widgets/mission/widgets/mission_type_list_item.dart';

class MissionTypeListScreen extends StatelessWidget {
  const MissionTypeListScreen({super.key});

  static const String routePath = "/mission-type";
  static const String routeName = "mission-type";

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
                  "Mission Type",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Gaps.v32,
              ListView.separated(
                padding: const EdgeInsets.only(bottom: 100),
                shrinkWrap: true,
                primary: false,
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: MissionType.values.length,
                itemBuilder: (context, index) {
                  final type = MissionType.values[index];
                  return Hero(
                    tag: type.name,
                    child: MissionTypeListItem(
                      type: type,
                      onTap: () => context.pushNamed(
                        MissionAddScreen.routeName,
                        extra: type,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
