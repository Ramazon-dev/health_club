import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    required this.imageUrl,
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.height = double.maxFinite,
    this.width = double.maxFinite,
    this.errorImageUrl,
    this.defaultWord,
    this.alignment,
    this.withDecoration = true,
    this.fit,
    this.margin = EdgeInsets.zero,
    this.iconBackColor,
    this.paddingErrorWidget = const EdgeInsets.all(36.0),
  });

  final String? imageUrl;
  final BorderRadius borderRadius;
  final double height;
  final double width;
  final String? errorImageUrl;
  final AlignmentGeometry? alignment;
  final bool withDecoration;
  final EdgeInsets margin;
  final String? defaultWord;
  final BoxFit? fit;
  final Color? iconBackColor;
  final EdgeInsets paddingErrorWidget;

  @override
  Widget build(BuildContext context) => Container(
    margin: margin,
    child: ClipRRect(
      borderRadius: borderRadius,
      child: (imageUrl != null && imageUrl?.isNotEmpty == true && imageUrl!.endsWith('.svg'))
          ? CachedNetworkSVGImage(
              imageUrl ?? "",
              fit: fit ?? BoxFit.cover,
              height: height,
              width: width,
              placeholderBuilder: (context) => SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.primaryColor)),
                ),
              ),
              errorWidget: defaultWord != null
                  ? Material(
                      color: iconBackColor ?? ThemeColors.primaryColor,
                      child: Center(
                        child: Text(
                          defaultWord?.isNotEmpty ?? false ? defaultWord![0].toUpperCase() : '',
                          // style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700).copyWith(color: context.colorScheme.secondary),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SvgPicture.asset(
                        'assets/icons/logo.svg',
                        height: height,
                        width: width,
                        colorFilter: ColorFilter.mode(Colors.grey.shade200, BlendMode.srcIn),
                      ),
                    ),
            )
          : CachedNetworkImage(
              imageUrl: imageUrl ?? '',
              fit: fit ?? BoxFit.cover,
              height: height,
              width: width,
              progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Center(
                  child: downloadProgress.totalSize != null
                      ? CircularProgressIndicator(
                          value: downloadProgress.progress,
                          valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.primaryColor),
                        )
                      : Icon(Icons.image_outlined, size: height, color: Colors.grey.shade200),
                ),
              ),
              errorWidget: (_, _, _) => defaultWord != null
                  ? Material(
                      color: iconBackColor ?? ThemeColors.primaryColor,
                      child: Center(
                        child: Text(
                          defaultWord?.isNotEmpty ?? false ? defaultWord![0].toUpperCase() : '',
                          // style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700).copyWith(color: context.colorScheme.secondary),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Padding(
                      padding: paddingErrorWidget,
                      child: SvgPicture.asset(AppAssets.logoSvg, height: height, width: width),
                    ),
            ),
    ),
  );
}
