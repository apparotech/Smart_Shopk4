
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomImage extends StatelessWidget {

  final String? imageurl;
  final double height;
  final double width;
  final BoxFit fit;


  CustomImage({
    this.imageurl,
    this.height = 100.0,
    this.width = double.infinity,
    this.fit = BoxFit.cover
});

  @override
  Widget build(BuildContext context) {
   return CachedNetworkImage(
       imageUrl: imageurl ?? '',
      errorWidget: (context, url, error) {
         return Icon(Icons.error);
      },
     height: height,
     fit: fit,
     width: width,
   );

  }

}