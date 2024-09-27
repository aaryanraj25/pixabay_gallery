import 'package:flutter/material.dart';
import 'package:pixabay_gallery/data/repositories/image_repository.dart';
import '../../domain/usecases/fetch_images.dart';
import '../../data/data_sources/remote_data_source.dart';
import '../widgets/image_grid_item.dart';
import '../../domain/entities/image_entity.dart';

/// A screen that displays a grid of images from the Pixabay API.
class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late FetchImages _fetchImages;
  List<ImageEntity> _images = [];
  bool _isLoading = false;
  int _page = 2;

  @override
  void initState() {
    super.initState();
    final remoteDataSource = RemoteDataSource();
    final imageRepository = ImageRepositoryImpl(remoteDataSource);
    _fetchImages = FetchImages(imageRepository);
    _loadImages(); // Load initial images
  }

  /// Loads images from the API.
  Future<void> _loadImages() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      final newImages = await _fetchImages.call(page: _page); // Pass the page number to load paginated results
      setState(() {
        _images.addAll(newImages);
        _isLoading = false;
        _page++; // Increment the page number for the next batch of images
      });
    }
  }

  /// Determines the number of grid columns based on the screen width.
  int _calculateCrossAxisCount(double screenWidth) {
    return (screenWidth / 200).floor(); // Each item gets 150px width approximately
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.pixels ==
                  scrollNotification.metrics.maxScrollExtent &&
              !_isLoading) {
            _loadImages(); // Load more images when reaching the bottom
          }
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26), // Padding from left and right
          child: LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = _calculateCrossAxisCount(constraints.maxWidth);
              return Column(
                children: [
                  SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1, // Ensures square aspect ratio for the grid items
                      ),
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        final image = _images[index];
                        return ImageGridItem(image: image); // Widget to display image, likes, and views
                      },
                    ),
                  ),
                  if (_isLoading) // Show circular indicator while loading new images
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Builds a custom AppBar with a unique design.
  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'All in one Gallery',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      elevation: 10,
      toolbarHeight: 70, // Make the app bar a bit taller for a modern look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30), // Curve the bottom edges of the AppBar
        ),
      ),
    );
  }
}
