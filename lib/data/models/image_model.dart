import '../../domain/entities/image_entity.dart';

class ImageModel extends ImageEntity {
  /// Creates an instance of [ImageModel].
  ImageModel({
    required String webformatUrl,
    required int likes,
    required int views,
  }) : super(webformatUrl: webformatUrl, likes: likes, views: views);

  /// Factory method to create an [ImageModel] from JSON.
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      webformatUrl: json['webformatURL'],
      likes: json['likes'],
      views: json['views'],
    );
  }
}
