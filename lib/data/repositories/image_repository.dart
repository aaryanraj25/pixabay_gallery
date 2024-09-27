import '../../domain/entities/image_entity.dart';
import '../../domain/repositories/image_repository.dart';
import '../data_sources/remote_data_source.dart';

class ImageRepositoryImpl implements ImageRepository {
  final RemoteDataSource remoteDataSource;

  ImageRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ImageEntity>> fetchImages({int page = 2}) async {
    return await remoteDataSource.fetchImagesFromApi(page: page);
  }
}

