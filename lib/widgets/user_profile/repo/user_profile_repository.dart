import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/models/user_profile.dart';
import 'package:mission_diary/util/file_util.dart';

class UserProfileRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createProfile(UserProfile user) async {
    await _db.collection("users").doc(user.userId).set(user.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String userId) async {
    final doc = await _db.collection("users").doc(userId).get();
    return doc.data();
  }

  Future<void> updateProfile(UserProfile user) async {
    await _db.collection("users").doc(user.userId).update(user.toJson());
  }

  Future<String> uploadAvatar(File file, String fileName) async {
    final compressedFile = await getCompressedImage(
      image: file,
      fileName: fileName,
      quality: 20,
    );
    final fileRef = _storage.ref().child("avatars/$fileName");
    await fileRef.putFile(compressedFile);
    return await fileRef.getDownloadURL();
  }

  Future<void> updateProfileInfo(
    String userId,
    Map<String, dynamic> data,
  ) async {
    await _db.collection("users").doc(userId).update(data);
  }
}

final profileRepo = Provider(
  (ref) => UserProfileRepository(),
);
