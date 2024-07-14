import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/widgets/feed/view_model/post_view_model.dart';
import 'package:mission_diary/widgets/feed/widgets/post_expanded_view.dart';
import 'package:mission_diary/widgets/feed/widgets/post_header.dart';
import 'package:mission_diary/widgets/feed/widgets/post_summary_view.dart';
import 'package:mission_diary/widgets/feed/widgets/post_user_avatar.dart';
import 'package:mission_diary/widgets/user_profile/view_model/user_profile_view_model.dart';

class PostView extends ConsumerStatefulWidget {
  const PostView({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  ConsumerState<PostView> createState() => _PostViewState();
}

class _PostViewState extends ConsumerState<PostView> {
  bool _isExpaneded = false;

  void _onSelectMenu(PopupMenu menu) {
    switch (menu) {
      case PopupMenu.edit:
      case PopupMenu.share:
        return;
      case PopupMenu.report:
        _onReportPost();
      case PopupMenu.delete:
        _onDeletePost();
    }
  }

  Future<void> _onReportPost() async {
    final result =
        await ref.read(postProvider(widget.post.postId).notifier).reportPost();
    if (mounted) {
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            content: Text(result),
          ),
        );
      }
    }
  }

  Future<void> _onDeletePost() async {
    final result =
        await ref.read(postProvider(widget.post.postId).notifier).deletePost();
    if (mounted) {
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            content: Text(result),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(postProvider(widget.post.postId)).when(
          data: (_) {
            final isMine =
                widget.post.authorId == ref.read(profileProvider).value?.userId;
            return isMine
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PostHeader(
                              post: widget.post,
                              onSelectMenu: _onSelectMenu,
                            ),
                            Gaps.v5,
                            PostSummaryView(
                              post: widget.post,
                              isMine: true,
                              onTap: () => setState(() {
                                _isExpaneded = !_isExpaneded;
                              }),
                            ),
                            PostExpandedView(
                              isExpaneded: _isExpaneded,
                              post: widget.post,
                            ),
                          ],
                        ),
                      ),
                      Gaps.h12,
                      PostUserAvatar(imgPath: widget.post.authorImgPath),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostUserAvatar(imgPath: widget.post.authorImgPath),
                      Gaps.h12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PostHeader(
                              post: widget.post,
                              onSelectMenu: _onSelectMenu,
                            ),
                            Gaps.v5,
                            PostSummaryView(
                              post: widget.post,
                              onTap: () => setState(() {
                                _isExpaneded = !_isExpaneded;
                              }),
                            ),
                            PostExpandedView(
                              isExpaneded: _isExpaneded,
                              post: widget.post,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
          },
          error: (err, stack) => Center(
            child: Text("error: $err"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
  }
}
