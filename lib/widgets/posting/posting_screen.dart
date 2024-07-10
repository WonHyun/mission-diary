import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';

class PostingScreen extends ConsumerStatefulWidget {
  const PostingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostingScreenState();
}

class _PostingScreenState extends ConsumerState<PostingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstraintedBody(
        child: Column(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const FaIcon(FontAwesomeIcons.chevronLeft),
            ),
            const Text("Posting"),
          ],
        ),
      ),
    );
  }
}
