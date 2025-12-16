import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BorderRadius? borderRadius;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius:
        borderRadius ?? BorderRadius.zero,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator.adaptive()),
          errorWidget: (context, url, error) => ColoredBox(
            color: Colors.blueGrey.shade100,
            child: const Center(
              child: Icon(Icons.error, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

class AppSvgNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BorderRadius? borderRadius;

  const AppSvgNetworkImage({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: CachedNetworkSVGImage(
          imageUrl,
          fit: BoxFit.cover,
          placeholderBuilder: (context) => const Center(child: CircularProgressIndicator.adaptive()),
          errorWidget: ColoredBox(
            color: Colors.blueGrey.shade100,
            child: const Center(
              child: Icon(Icons.error, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
