import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/enum.dart';
import 'package:mission_diary/models/media_item.dart';
import 'package:mission_diary/models/post.dart';
import 'package:mission_diary/util/file_util.dart';

class PostingRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPost(
    Post post,
    List<MediaItem> selectedMedia,
  ) async {
    Post newPost = post.copyWith();
    newPost = newPost.copyWith(
      mediaUrlList: await uploadMedias(newPost, selectedMedia),
    );
    await _db.collection("posts").doc(post.postId).set(newPost.toJson());
  }

  Future<List<String>> uploadMedias(
    Post post,
    List<MediaItem> selectedMedia,
  ) async {
    List<String> updatedMediaUrlList = [];
    for (int i = 0; i < selectedMedia.length; i++) {
      MediaItem media = selectedMedia[i];
      if (media.mediaType == MediaType.image) {
        if (media.mediaPathType == MediaPathType.file) {
          final fileRef = _storage
              .ref()
              .child("/posts/${post.postId}/medias/${media.mediaId}");

          var file = File(media.path);

          if (media.mediaType == MediaType.image) {
            file = await getCompressedImage(
              image: file,
              fileName: media.mediaId,
            );
          }

          final result = await fileRef.putFile(file);
          if (result.metadata != null) {
            updatedMediaUrlList.add(await result.ref.getDownloadURL());
          }
        } else {
          updatedMediaUrlList.add(media.path);
        }
      }
    }
    return updatedMediaUrlList;
  }
}

final postingRepo = Provider((ref) => PostingRepository());
