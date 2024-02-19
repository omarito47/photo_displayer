import 'package:flutter/material.dart';
import 'package:photo_displayer/global/models/photo.dart';
import 'package:photo_displayer/modules/photo_detail.dart/widgets/photo_detail.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoItemCard extends StatelessWidget {
  const PhotoItemCard({
    super.key,
    required this.photos,
  });

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoDetail(photo: photo),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: 100,
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: photo.thumbnailUrl!,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(flex: 3, child: Text(photo.title!)),
              ],
            ),
          ),
        );
      },
    );
  }
}
