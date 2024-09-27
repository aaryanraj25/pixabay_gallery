import 'package:flutter/material.dart';
import '../../domain/entities/image_entity.dart';

/// A widget that displays an image with its likes and views.
class ImageGridItem extends StatelessWidget {
  final ImageEntity image;

  /// Creates an instance of [ImageGridItem].
  const ImageGridItem({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // Ensures the image takes the full width of the grid cell
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              image.webformatUrl, // <-- Replace with the correct field from ImageEntity
              fit: BoxFit.cover, // Ensures the image covers the entire grid cell without distortion
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${image.likes} Likes',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text(
                '${image.views} Views',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
