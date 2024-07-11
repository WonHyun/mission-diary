import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/widgets/setting/setting_screen.dart';
import 'package:mission_diary/widgets/user_profile/user_profile_edit_screen.dart';
import 'package:mission_diary/widgets/user_profile/view_model/user_profile_view_model.dart';
import 'package:mission_diary/widgets/user_profile/widgets/editable_avatar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  static const String routePath = "/profile";
  static const String routeName = "profile";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ref.watch(profileProvider).when(
            data: (profile) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => context
                              .pushNamed(UserProfileEditScreen.routeName),
                          child: const FaIcon(FontAwesomeIcons.solidCircleUser),
                        ),
                        Gaps.h20,
                        GestureDetector(
                          onTap: () =>
                              context.pushNamed(SettingScreen.routeName),
                          child: const FaIcon(FontAwesomeIcons.gear),
                        ),
                      ],
                    ),
                    Gaps.v20,
                    EditableAvatar(
                      profile: profile,
                      size: Sizes.size48,
                    ),
                    Gaps.v20,
                    Text(
                      profile.userName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Gaps.v10,
                    Text(profile.email),
                    Gaps.v20,
                    BioTextView(bio: profile.bio),
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

class BioTextView extends StatelessWidget {
  const BioTextView({
    super.key,
    required this.bio,
  });

  final String bio;

  @override
  Widget build(BuildContext context) {
    return Text(bio.isEmpty ? "Hello World!" : bio);
  }
}
