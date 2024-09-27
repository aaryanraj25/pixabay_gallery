import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pixabay_gallery/domain/entities/image_entity.dart';


class RemoteDataSource {
  final String apiKey = '46208754-3b170f6cf7e82aa6abaa8b8b7';
  final String baseUrl = 'https://pixabay.com/api/';

  /// Fetches images from the Pixabay API with pagination.
  Future<List<ImageEntity>> fetchImagesFromApi({int page = 2}) async {
    final response = await http.get(Uri.parse('$baseUrl?key=$apiKey&page=$page'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['hits'];
      return data.map((json) => ImageEntity.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}

