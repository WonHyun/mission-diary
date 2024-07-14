import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/post.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  DocumentSnapshot? lastDocument;

  Future<List<Post>> fetchPosts({bool isRefresh = false}) async {
    var query =
        _db.collection("posts").orderBy("createdAt", descending: true).limit(3);

    if (lastDocument != null && !isRefresh) {
      query = query.startAfterDocument(lastDocument!);
    }

    final result = await query.get();

    if (result.docs.isNotEmpty) {
      lastDocument = result.docs.last;
    }

    final posts = result.docs
        .map(
          (doc) => Post.fromJson(doc.data()),
        )
        .toList();

    return posts;
  }

  Future<void> deletePost(String postId) async {
    await _db.collection("posts").doc(postId).delete();

    // Delete Post medias
    final result = await _storage.ref('posts/$postId/medias').listAll();
    for (var item in result.items) {
      await item.delete();
    }
  }
}

final postRepo = Provider((ref) => PostRepository());
