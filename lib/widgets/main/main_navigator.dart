import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/global/value.dart';
import 'package:mission_diary/widgets/activity/activity_screen.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';
import 'package:mission_diary/widgets/common/gradient_button.dart';
import 'package:mission_diary/widgets/feed/feed_screen.dart';
import 'package:mission_diary/widgets/home/home_screen.dart';
import 'package:mission_diary/widgets/main/widgets/navigator_menu_icon.dart';
import 'package:mission_diary/widgets/posting/posting_screen.dart';
import 'package:mission_diary/widgets/user_profile/user_profile_screen.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({
    super.key,
    required this.type,
    required this.child,
  });

  final MainNavigatorType type;
  final Widget child;

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstraintedBody(
        child: Stack(
          children: [
            Positioned.fill(child: widget.child),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: OpenContainer(
                tappable: false,
                openColor: Theme.of(context).colorScheme.surface,
                openBuilder: (context, openCallback) => const PostingScreen(),
                openElevation: 1,
                transitionType: ContainerTransitionType.fadeThrough,
                transitionDuration: const Duration(milliseconds: 500),
                closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                closedColor: isDarkMode(context)
                    ? Colors.grey.shade900
                    : Theme.of(context).colorScheme.surface,
                closedElevation: 1,
                closedBuilder: (context, openCallback) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        NavigatorMenuIcon(
                          onTap: () => context.goNamed(HomeScreen.routeName),
                          selectedIcon: FontAwesomeIcons.house,
                          unselectedIcon: FontAwesomeIcons.house,
                          isSelected: widget.type == MainNavigatorType.home,
                        ),
                        NavigatorMenuIcon(
                          onTap: () => context.goNamed(FeedScreen.routeName),
                          selectedIcon: FontAwesomeIcons.solidNewspaper,
                          unselectedIcon: FontAwesomeIcons.newspaper,
                          isSelected: widget.type == MainNavigatorType.feed,
                        ),
                        GradientButton(
                          onTap: openCallback,
                          icon: FontAwesomeIcons.pen,
                        ),
                        NavigatorMenuIcon(
                          onTap: () =>
                              context.goNamed(ActivityScreen.routeName),
                          selectedIcon: FontAwesomeIcons.chartSimple,
                          unselectedIcon: FontAwesomeIcons.chartSimple,
                          isSelected: widget.type == MainNavigatorType.activity,
                        ),
                        NavigatorMenuIcon(
                          onTap: () =>
                              context.goNamed(UserProfileScreen.routeName),
                          selectedIcon: FontAwesomeIcons.solidUser,
                          unselectedIcon: FontAwesomeIcons.solidUser,
                          isSelected: widget.type == MainNavigatorType.profile,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
