import 'package:flutter/material.dart';
import 'package:photo_displayer/modules/photo_detail.dart/widgets/photo_detail_card.dart';
import 'package:photo_displayer/global/models/photo.dart';
import 'package:photo_displayer/global/services/api/photo_services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoDetail extends StatefulWidget {
  final Photo photo;

  PhotoDetail({Key? key, required this.photo}) : super(key: key);

  @override
  State<PhotoDetail> createState() => _PhotoDetailState();
}

class _PhotoDetailState extends State<PhotoDetail> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPhoto();
  }

  Future<void> _loadPhoto() async {
    await Future.delayed(
        Duration(seconds: 3)); // Simulating photo loading delay
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final photoServiceProvider = Provider.of<PhotoServiceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Detail"),
      ),
      body: Center(
        child: FutureBuilder<List<Photo>>(
          future: photoServiceProvider.getPhotos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: MediaQuery.of(context).size.width * .85,
                  height: MediaQuery.of(context).size.height * .5,
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasData) {
              final photos = snapshot.data!;
              return buildPhotoDetail(isLoading: _isLoading, widget: widget);
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }
}
