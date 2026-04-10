import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final bool rounded;
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.rounded = false,
  });

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100.r),
        child: Image.network(
          imageUrl,
          width: width?.w,
          height: height?.sp,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              TablerIcons.fileBroken,
              color: Colors.grey,
              size: width != null ? width! / 2 : null,
            );
          },
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width?.w,
        height: height?.sp,
        errorWidget: (context, error, stackTrace) {
          return Icon(
            TablerIcons.fileBroken,
            color: Colors.grey,
            size: (width != null ? width! / 2 : null),
          );
        },
      ),
    );
  }
}
