import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final String image;
  final double width;
  const RoundedImage(this.image, this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        image,
        width: width,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error_outline);
        },
      ),
    );
  }
}
