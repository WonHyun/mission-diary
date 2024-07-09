import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/widgets/authentication/login_screen.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';
import 'package:mission_diary/widgets/common/linked_text.dart';
import 'package:mission_diary/widgets/common/rounded_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  static const String routePath = "/";
  static const String routeName = "intro";

  void _onTapLogin(BuildContext context) {
    context.goNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstraintedBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 50,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Flexible(
              flex: 25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mission Diary",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  Gaps.v20,
                  Text(
                    "Plan what you will do to be more interested for today.",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size20,
                    ),
                    child: RoundedButton(
                      onTap: () => _onTapLogin(context),
                      text: "Login",
                      borderRadius: Sizes.size12,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fontColor: Colors.white,
                    ),
                  ),
                  Gaps.v24,
                  const LinkedText(text: "Sign Up")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
