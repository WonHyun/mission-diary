import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/widgets/feed/view_model/feed_view_model.dart';
import 'package:mission_diary/widgets/feed/widgets/post_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  static const String routePath = "/feed";
  static const String routeName = "feed";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final RefreshController _controller =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ref.watch(feedProvider).when(
            data: (posts) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: SmartRefresher(
                  controller: _controller,
                  enablePullUp: true,
                  enablePullDown: true,
                  onRefresh: () async {
                    await ref.read(feedProvider.notifier).refresh();
                    _controller.refreshCompleted();
                  },
                  onLoading: () async {
                    await ref.read(feedProvider.notifier).fetchNextPosts();
                    _controller.loadComplete();
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverList.separated(
                        separatorBuilder: (context, index) => Gaps.v20,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return PostView(post: posts[index]);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (err, stack) => Center(
              child: Text("error: $err"),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
    );
  }
}
