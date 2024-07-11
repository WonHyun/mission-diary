import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/models/user_profile.dart';
import 'package:mission_diary/widgets/user_profile/user_profile_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.profile,
  });

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Hello, Agt.${profile.userName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: Sizes.size8),
              child: GestureDetector(
                onTap: () => context.goNamed(UserProfileScreen.routeName),
                child: CircleAvatar(
                  foregroundImage: profile.profileImgPath.isEmpty
                      ? null
                      : NetworkImage(profile.profileImgPath),
                ),
              ),
            ),
          ],
        ),
        Text(
          "Here is your mission",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w300,
              ),
        ),
      ],
    );
  }
}
