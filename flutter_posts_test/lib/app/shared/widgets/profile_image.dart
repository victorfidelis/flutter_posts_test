import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  const ProfileImage({super.key, required this.url, required this.width, required this.height}); 

  @override
  Widget build(BuildContext context) {
    return Hero(
          tag: 'userProfile',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: url,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
        );
  }
}