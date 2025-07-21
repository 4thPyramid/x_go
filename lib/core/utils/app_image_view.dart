import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:x_go/core/utils/image_url_helper.dart';

class AppImageView extends StatelessWidget {
  final String? imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final bool isAvatar;
  final BoxFit? fit;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;
  final String? placeHolderImage;
  final String? tag;

  const AppImageView(
    this.imagePath, {
    super.key,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.isAvatar = false,
    this.placeHolderImage,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget())
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(onTap: onTap, child: _buildCircleImage()),
    );
  }

  Widget _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  Widget _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(border: border, borderRadius: radius),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (imagePath != null) {
      switch (imagePath!.imageType) {
        case ImageType.svgNetwork:
          return SvgPicture.network(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            colorFilter: color == null
                ? null
                : ColorFilter.mode(color!, BlendMode.srcIn),
          );
        case ImageType.svg:
          return SvgPicture.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            colorFilter: color == null
                ? null
                : ColorFilter.mode(color!, BlendMode.srcIn),
          );
        case ImageType.file:
          return Image.file(
            File(imagePath!),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
        case ImageType.network:
          return CachedNetworkImage(
            height: height,
            width: width,
            fit: fit ?? BoxFit.fill,
            imageUrl: ImageUrlHelper.normalizeImageUrl(imagePath!),
            color: color,
            imageBuilder: (context, imageProvider) => InkWell(
              onDoubleTap: () {
                imageHeroFunction(
                  context,
                  imageProvider,
                  tag: tag ?? "$imagePath$hashCode",
                );
              },
              onLongPress: () {
                imageHeroFunction(
                  context,
                  imageProvider,
                  tag: tag ?? "$imagePath$hashCode",
                );
              },
              child: Hero(
                tag: tag ?? "$imagePath$hashCode",
                child: Container(
                  height: height,
                  width: width,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(color: color ?? AppColors.white),
                    borderRadius: radius,
                    shape: isAvatar ? BoxShape.circle : BoxShape.rectangle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: fit ?? BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            placeholder: (context, url) => AppShimmer(avatar: isAvatar),
            errorWidget: (context, url, error) => placeHolderImage != null
                ? Image.asset(placeHolderImage!)
                : AppShimmer(avatar: isAvatar),
          );

        case ImageType.png:
        default:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
      }
    }
    return const SizedBox();
  }
}

enum ImageType { svg, png, network, file, unknown, svgNetwork }

extension ImageTypeExtension on String {
  ImageType get imageType {
    if ((startsWith('http') || startsWith('https')) && endsWith('.svg')) {
      return ImageType.svgNetwork;
    } else if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://') || startsWith('/data/user')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

Future<dynamic> imageHeroFunction(
  BuildContext context,
  var imageProvider, {
  String? tag,
}) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        body: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: tag ?? imageProvider,
            child: Container(
              color: Colors.black,
              width: double.infinity,
              height: double.infinity,
              child: Image(image: imageProvider),
            ),
          ),
        ),
      ),
    ),
  );
}
