import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future<File> getCompressedImage({
  required File image,
  required String fileName,
  int quality = 30,
}) async {
  try {
    var compressedImage = await FlutterImageCompress.compressWithList(
      await image.readAsBytes(),
      quality: quality,
    );

    final directory = await getApplicationDocumentsDirectory();
    final tempDirectory = Directory('${directory.path}/temp');

    if (!await tempDirectory.exists()) {
      await tempDirectory.create(recursive: true);
    }

    final path = '${tempDirectory.path}/$fileName.png';

    return await File(path).writeAsBytes(compressedImage);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return File(image.path);
  }
}
