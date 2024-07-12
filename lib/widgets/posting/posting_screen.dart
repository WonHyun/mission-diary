import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';
import 'package:mission_diary/widgets/common/rounded_button.dart';

class PostingScreen extends ConsumerStatefulWidget {
  const PostingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostingScreenState();
}

class _PostingScreenState extends ConsumerState<PostingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstraintedBody(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: const FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    size: Sizes.size20,
                  ),
                ),
                title: Text(
                  "Share",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Gaps.v20,
              RoundedButton(
                onTap: () => {},
                text: "Share",
                fontColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
