class ImageEntity {
  final String webformatUrl;
  final int likes;
  final int views;

  /// Constructor for the ImageEntity class
  ImageEntity({
    required this.webformatUrl,
    required this.likes,
    required this.views,
  });

  /// A factory constructor that converts JSON into an ImageEntity object.
  factory ImageEntity.fromJson(Map<String, dynamic> json) {
    return ImageEntity(
      webformatUrl: json['webformatURL'] as String, // Matches the API field
      likes: json['likes'] as int,
      views: json['views'] as int,
    );
  }
}
