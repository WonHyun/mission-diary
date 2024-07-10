import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/widgets/authentication/intro_screen.dart';
import 'package:mission_diary/widgets/authentication/view_model/login_view_model.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  static const String routePath = "/profile";
  static const String routeName = "profile";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  Future<void> _onTapLogout() async {
    await ref.read(loginProvider.notifier).logout();
    if (mounted) {
      context.goNamed(IntroScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const Text("User profile"),
          TextButton(
            onPressed: _onTapLogout,
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
