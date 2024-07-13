import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/widgets/posting/view_model/media_view_model.dart';

class PostingMediaListView extends ConsumerWidget {
  const PostingMediaListView({
    super.key,
    this.height = 150,
    this.width = 200,
  });

  final double height;
  final double width;

  void _onTapDelete(WidgetRef ref) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(mediaProvider).when(
          data: (medias) {
            return SizedBox(
              height: height,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => Gaps.h10,
                itemCount: medias.length,
                itemBuilder: (context, index) {
                  final media = medias[index];
                  return Stack(
                    children: [
                      Container(
                        width: width,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: media.mediaPathType == MediaPathType.url
                            ? Image.network(
                                media.path,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(media.path),
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => ref
                              .read(mediaProvider.notifier)
                              .deleteMedia(media),
                          child: Container(
                            padding: const EdgeInsets.all(Sizes.size8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.x,
                              size: Sizes.size12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
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
