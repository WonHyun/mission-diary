import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/widgets/authentication/intro_screen.dart';
import 'package:mission_diary/widgets/authentication/login_screen.dart';
import 'package:mission_diary/widgets/authentication/repo/authentication_repository.dart';
import 'package:mission_diary/widgets/authentication/sign_up_screen.dart';
import 'package:mission_diary/widgets/home/home_screen.dart';
import 'package:mission_diary/widgets/main/main_navigator.dart';
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
        ShellRoute(
          parentNavigatorKey: _rootNavigatorKey,
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            late MainNavigatorType type;
            switch (state.matchedLocation) {
              case HomeScreen.routePath:
                type = MainNavigatorType.home;
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
              path: UserProfileScreen.routePath,
              name: UserProfileScreen.routeName,
              builder: (context, state) => const UserProfileScreen(),
            ),
          ],
        ),
      ],
    );
  },
);
