import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/widgets/common/check_circle.dart';
import 'package:mission_diary/widgets/common/safe_image.dart';
import 'package:mission_diary/widgets/posting/view_model/media_view_model.dart';

class PostingMediaListView extends ConsumerWidget {
  const PostingMediaListView({
    super.key,
    this.height = 150,
    this.width = 200,
  });

  final double height;
  final double width;

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
                  return GestureDetector(
                    onTap: () =>
                        ref.read(mediaProvider.notifier).selectMedia(media),
                    child: Stack(
                      children: [
                        Container(
                          width: width,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SafeImage(
                            path: media.path,
                            pathType: media.mediaPathType,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: CheckCircle(isChecked: media.isSelected),
                        ),
                      ],
                    ),
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
