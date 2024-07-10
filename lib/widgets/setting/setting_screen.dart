import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/widgets/authentication/intro_screen.dart';
import 'package:mission_diary/widgets/authentication/view_model/login_view_model.dart';
import 'package:mission_diary/widgets/common/adaptive_dialog_action.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';
import 'package:mission_diary/widgets/setting/view_model/setting_view_model.dart';
import 'package:mission_diary/widgets/setting/widgets/theme_mode_selector.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  static const String routePath = "/setting";
  static const String routeName = "setting";

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  Future<void> _onLogout() async {
    await ref.read(loginProvider.notifier).logout();
    if (mounted) {
      context.goNamed(IntroScreen.routeName);
    }
  }

  Future<void> _onTapLogout() async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text("Confirm Logout"),
          content: const Text(
            "Are you sure you want to log out?",
          ),
          actions: [
            AdaptiveDialogAction(
              context: context,
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Not yet",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            AdaptiveDialogAction(
              context: context,
              onPressed: () async {
                await _onLogout();
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: ConstraintedBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "General",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Gaps.v10,
            ListTile(
              onTap: () => {},
              title: const Text("Language"),
              trailing: const SizedBox(
                width: 80,
                child: Padding(
                  padding: EdgeInsets.only(right: Sizes.size5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("English"),
                      FaIcon(
                        FontAwesomeIcons.chevronRight,
                        size: Sizes.size16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text("Theme"),
              trailing: ThemeModeSelector(
                onThemeChanged:
                    ref.read(settingProvider.notifier).updateThemeMode,
                currentThemeMode: ref.watch(settingProvider).themeMode,
              ),
            ),
            Gaps.v20,
            Text(
              "Notifications",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Gaps.v10,
            SwitchListTile(
              title: const Text("Allow Notification"),
              value: ref.watch(settingProvider).isAllowNotification,
              onChanged:
                  ref.read(settingProvider.notifier).updateIsAllowNotification,
            ),
            SwitchListTile(
              title: const Text("Allow the Notification Rings"),
              value: ref.watch(settingProvider).isAllowNotificationRing,
              onChanged: ref
                  .read(settingProvider.notifier)
                  .updateIsAllowNotificationRing,
            ),
            const Divider(),
            ListTile(
              onTap: _onTapLogout,
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              trailing: const Icon(
                FontAwesomeIcons.arrowRightFromBracket,
                size: Sizes.size16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
