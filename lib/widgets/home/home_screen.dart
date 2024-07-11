import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/widgets/home/widgets/home_header.dart';
import 'package:mission_diary/widgets/home/widgets/today_mission_list_view.dart';
import 'package:mission_diary/widgets/user_profile/view_model/user_profile_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
  });

  static const String routePath = "/home";
  static const String routeName = "home";

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ref.watch(profileProvider).when(
            data: (profile) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(profile: profile),
                    Gaps.v48,
                    const TodayMissionListView(),
                  ],
                ),
              );
            },
            error: (err, stack) => Center(
              child: Text("error: $err"),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
    );
  }
}
