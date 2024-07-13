import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/post.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
}

final postRepo = Provider((ref) => PostRepository());
