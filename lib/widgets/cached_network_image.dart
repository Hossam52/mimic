import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'loading_brogress.dart';

Widget cachedNetworkImage({
  required String imageUrl,
  required double height,
  required double width,
}) 
{
  return 
  
    CachedNetworkImage(
    imageUrl: imageUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) => const LoadingProgress(),
    height: height,
    width: width,
    errorWidget: (context, url, error) =>
        const Center(child: Icon(Icons.error)),
  );
}
