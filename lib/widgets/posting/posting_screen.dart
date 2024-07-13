import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/models/media_item.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';
import 'package:mission_diary/widgets/common/rounded_button.dart';
import 'package:mission_diary/widgets/posting/view_model/posting_view_model.dart';
import 'package:mission_diary/widgets/posting/widgets/posting_media_list_view.dart';

class PostingScreen extends ConsumerStatefulWidget {
  const PostingScreen({super.key});

  static const String routePath = "/posting";
  static const String routeName = "posting";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostingScreenState();
}

class _PostingScreenState extends ConsumerState<PostingScreen> {
  late final TextEditingController _controller =
      TextEditingController(text: "");

  final List<MediaItem> mediaList = [];

  Future<void> _onTapShare() async {
    final result = await ref.read(postingProvider.notifier).completePosting(
          content: _controller.text,
          selectedMedia: mediaList,
        );

    if (result != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          content: Text(result),
        ),
      );
    } else {
      if (mounted) {
        context.pop("complete");
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
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
                Text(
                  "Select Photos",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Gaps.v20,
                const PostingMediaListView(),
                Gaps.v36,
                TextField(
                  controller: _controller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Let's write something.",
                    hintStyle: const TextStyle(color: Colors.grey),
                    labelText: "How are you today?",
                    labelStyle: const TextStyle(color: Colors.grey),
                    floatingLabelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface),
                  ),
                ),
                Gaps.v48,
                RoundedButton(
                  onTap: _onTapShare,
                  text: "Share",
                  fontColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  isActive: !ref.watch(postingProvider).isLoading,
                  centerWidget: ref.watch(postingProvider).isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
