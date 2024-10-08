import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/widgets/activity/activity_screen.dart';
import 'package:mission_diary/widgets/authentication/intro_screen.dart';
import 'package:mission_diary/widgets/authentication/login_screen.dart';
import 'package:mission_diary/widgets/authentication/repo/authentication_repository.dart';
import 'package:mission_diary/widgets/authentication/sign_up_screen.dart';
import 'package:mission_diary/widgets/feed/feed_screen.dart';
import 'package:mission_diary/widgets/home/home_screen.dart';
import 'package:mission_diary/widgets/mission/mission_add_screen.dart';
import 'package:mission_diary/widgets/mission/mission_edit_screen.dart';
import 'package:mission_diary/widgets/main/main_navigator.dart';
import 'package:mission_diary/widgets/mission/mission_type_list_screen.dart';
import 'package:mission_diary/widgets/posting/mission_status_screen.dart';
import 'package:mission_diary/widgets/posting/posting_screen.dart';
import 'package:mission_diary/widgets/setting/setting_screen.dart';
import 'package:mission_diary/widgets/user_profile/user_profile_edit_screen.dart';
import 'package:mission_diary/widgets/user_profile/user_profile_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: HomeScreen.routePath,
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.matchedLocation != SignUpScreen.routePath &&
              state.matchedLocation != LoginScreen.routePath) {
            return IntroScreen.routePath;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          path: IntroScreen.routePath,
          name: IntroScreen.routeName,
          builder: (context, state) => const IntroScreen(),
        ),
        GoRoute(
          path: LoginScreen.routePath,
          name: LoginScreen.routeName,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: SignUpScreen.routePath,
          name: SignUpScreen.routeName,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          name: SettingScreen.routeName,
          path: SettingScreen.routePath,
          builder: (context, state) => const SettingScreen(),
        ),
        GoRoute(
          name: UserProfileEditScreen.routeName,
          path: UserProfileEditScreen.routePath,
          builder: (context, state) => const UserProfileEditScreen(),
        ),
        GoRoute(
          name: MissionStatusScreen.routeName,
          path: MissionStatusScreen.routePath,
          builder: (context, state) => const MissionStatusScreen(),
        ),
        GoRoute(
          name: PostingScreen.routeName,
          path: PostingScreen.routePath,
          builder: (context, state) => const PostingScreen(),
        ),
        GoRoute(
          path: MissionTypeListScreen.routePath,
          name: MissionTypeListScreen.routeName,
          builder: (context, state) => const MissionTypeListScreen(),
        ),
        GoRoute(
          path: MissionAddScreen.routePath,
          name: MissionAddScreen.routeName,
          builder: (context, state) {
            MissionType type;
            if (state.extra is MissionType) {
              type = state.extra as MissionType;
            } else {
              type = MissionType.etc;
            }
            return MissionAddScreen(
              type: type,
            );
          },
        ),
        GoRoute(
          path: MissionEditScreen.routePath,
          name: MissionEditScreen.routeName,
          builder: (context, state) => const MissionEditScreen(),
        ),
        ShellRoute(
          parentNavigatorKey: _rootNavigatorKey,
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            late MainNavigatorType type;
            switch (state.matchedLocation) {
              case HomeScreen.routePath:
                type = MainNavigatorType.home;
              case FeedScreen.routePath:
                type = MainNavigatorType.feed;
              case ActivityScreen.routePath:
                type = MainNavigatorType.activity;
              case UserProfileScreen.routePath:
              default:
                type = MainNavigatorType.profile;
            }
            return MainNavigator(
              type: type,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: HomeScreen.routePath,
              name: HomeScreen.routeName,
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: FeedScreen.routePath,
              name: FeedScreen.routeName,
              builder: (context, state) => const FeedScreen(),
            ),
            GoRoute(
              path: UserProfileScreen.routePath,
              name: UserProfileScreen.routeName,
              builder: (context, state) => const UserProfileScreen(),
            ),
            GoRoute(
              path: ActivityScreen.routePath,
              name: ActivityScreen.routeName,
              builder: (context, state) => const ActivityScreen(),
            ),
          ],
        ),
      ],
    );
  },
);
