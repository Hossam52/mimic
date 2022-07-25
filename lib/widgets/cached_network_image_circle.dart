import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'loading_brogress.dart';
import 'rounded_image.dart';

Widget cachedNetworkImageProvider(String? imageUrl, double radius) {
  return imageUrl == null
      ? RoundedImage(
          imagePath: 'assets/images/static/avatar.png',
          size: radius,
        )
      : CachedNetworkImage(
          imageUrl: imageUrl,
          
          placeholder: (context, url) =>
              CircleAvatar(radius: radius, child: const LoadingProgress()),
          errorWidget: (context, url, error) =>
              CircleAvatar(radius: radius, child: const Icon(Icons.error)),
          imageBuilder: (context, imageProvider) {
            
            return Align(
              alignment: AlignmentDirectional.center,
              child: 
              CircleAvatar(
                radius: radius,
                backgroundImage: imageProvider,

              ),
            );
          },
        );
}
