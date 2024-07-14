import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/util/date_util.dart';
import 'package:mission_diary/widgets/user_profile/view_model/user_profile_view_model.dart';

class PostHeader extends ConsumerWidget {
  const PostHeader({
    super.key,
    required this.post,
    required this.onSelectMenu,
  });

  final Post post;
  final Function(PopupMenu) onSelectMenu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            post.authorUserName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Row(
          children: [
            Text(getTimeAgoFormat(post.createdAt)),
            Gaps.h8,
            PopupMenuButton(
              icon: const FaIcon(FontAwesomeIcons.ellipsis),
              iconSize: Sizes.size18,
              constraints: const BoxConstraints(minWidth: 0),
              position: PopupMenuPosition.under,
              padding: EdgeInsets.zero,
              onSelected: onSelectMenu,
              itemBuilder: (context) {
                return [
                  if (post.authorId == ref.read(profileProvider).value?.userId)
                    PopupMenuItem(
                      value: PopupMenu.edit,
                      child: ListTile(
                        leading: Icon(
                          PopupMenu.edit.icon,
                          size: Sizes.size14,
                        ),
                        title: Text(
                          PopupMenu.edit.text,
                          style: const TextStyle(
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                    ),
                  PopupMenuItem(
                    value: PopupMenu.share,
                    child: ListTile(
                      leading: Icon(
                        PopupMenu.share.icon,
                        size: Sizes.size14,
                      ),
                      title: Text(
                        PopupMenu.share.text,
                        style: const TextStyle(
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: PopupMenu.report,
                    child: ListTile(
                      leading: Icon(
                        PopupMenu.report.icon,
                        size: Sizes.size14,
                        color: Colors.red,
                      ),
                      title: Text(
                        PopupMenu.report.text,
                        style: const TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  if (post.authorId == ref.read(profileProvider).value?.userId)
                    PopupMenuItem(
                      value: PopupMenu.delete,
                      child: ListTile(
                        leading: Icon(
                          PopupMenu.delete.icon,
                          size: Sizes.size14,
                          color: Colors.red,
                        ),
                        title: Text(
                          PopupMenu.delete.text,
                          style: const TextStyle(
                            fontSize: Sizes.size16,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                ];
              },
            ),
          ],
        ),
      ],
    );
  }
}
