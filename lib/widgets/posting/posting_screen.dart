import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';
import 'package:mission_diary/widgets/common/rounded_button.dart';
import 'package:mission_diary/widgets/posting/view_model/media_view_model.dart';
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

  Future<void> _onTapShare() async {
    final result = await ref.read(postingProvider.notifier).completePosting(
          content: _controller.text,
          selectedMedia: ref
                  .read(mediaProvider)
                  .value
                  ?.where((media) => media.isSelected)
                  .toList() ??
              [],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Photos",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              ref.read(mediaProvider.notifier).selectAll(true),
                          child: const Icon(
                            FontAwesomeIcons.images,
                            size: Sizes.size20,
                          ),
                        ),
                        Gaps.h16,
                        GestureDetector(
                          onTap: () =>
                              ref.read(mediaProvider.notifier).selectAll(false),
                          child: const Icon(
                            Icons.image_not_supported_rounded,
                            size: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
                  ],
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
