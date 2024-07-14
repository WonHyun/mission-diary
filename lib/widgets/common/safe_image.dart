import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mission_diary/global/enum.dart';

class SafeImage extends StatelessWidget {
  const SafeImage({
    super.key,
    required this.path,
    required this.pathType,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String path;
  final MediaPathType pathType;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return pathType == MediaPathType.url
        ? Image.network(
            path,
            fit: fit,
            width: width,
            height: height,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.image_not_supported_rounded),
            ),
          )
        : Image.file(
            File(path),
            fit: fit,
            width: width,
            height: height,
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.image_not_supported_rounded),
            ),
          );
  }
}
