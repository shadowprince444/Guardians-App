import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePreviewScreen extends StatelessWidget {
  const ImagePreviewScreen({
    required this.imageUrl,
    this.heroTag = '',
    super.key,
  });

  final String imageUrl;
  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Hero(
          tag: heroTag,
          child: Center(
            child: InteractiveViewer(
              maxScale: 5,
              clipBehavior: Clip.none,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
