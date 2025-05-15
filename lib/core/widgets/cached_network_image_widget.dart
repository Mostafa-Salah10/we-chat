import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.height,
    this.width,
    this.errWidget,
  });
  final String imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Widget? errWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      imageUrl: imageUrl,
      progressIndicatorBuilder:
          (context, url, downloadProgress) => CupertinoActivityIndicator(),
      errorWidget: (context, url, error) => errWidget ?? Icon(Icons.error),
    );
  }
}
