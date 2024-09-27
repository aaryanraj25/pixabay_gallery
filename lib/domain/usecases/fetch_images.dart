import '../repositories/image_repository.dart';
import '../entities/image_entity.dart';

class FetchImages {
  final ImageRepository imageRepository;

  FetchImages(this.imageRepository);

  /// Fetches images from the repository with optional pagination.
  Future<List<ImageEntity>> call({int page = 2}) async {
    return await imageRepository.fetchImages(page: page);
  }
}

