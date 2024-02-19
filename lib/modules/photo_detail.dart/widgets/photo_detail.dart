import 'package:flutter/material.dart';
import 'package:photo_displayer/modules/list_photos/widgets/list_photo.dart';
import 'package:photo_displayer/modules/photo_detail.dart/widgets/next_page.dart';
import 'package:photo_displayer/modules/photo_detail.dart/widgets/photo_detail_card.dart';
import 'package:photo_displayer/global/models/photo.dart';
import 'package:photo_displayer/global/services/api/photo_services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PhotoDetail extends StatefulWidget {
  final Photo photo;

  const PhotoDetail({Key? key, required this.photo}) : super(key: key);

  @override
  State<PhotoDetail> createState() => _PhotoDetailState();
}

class _PhotoDetailState extends State<PhotoDetail> {
  final bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final photoServiceProvider = Provider.of<PhotoServiceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Detail"),
        actions: [
          Container(
            margin:
                EdgeInsets.only(right: MediaQuery.of(context).size.width * .05),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NextPage(),
                    ),
                  );
                },
                child: const Icon(Icons.arrow_forward_rounded)),
          )
        ],
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PhotosList(),
                ),
              );
            },
            child: const Icon(Icons.arrow_back_rounded)),
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
              return BuildPhotoDetail(isLoading: _isLoading, widget: widget);
            } else {
              return Placeholder();
            }
          },
        ),
      ),
    );
  }
}
