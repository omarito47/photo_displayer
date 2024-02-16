import 'package:flutter/material.dart';
import 'package:photo_displayer/modules/photo_detail.dart/widgets/photo_detail.dart';
import 'package:transparent_image/transparent_image.dart';

class buildPhotoDetail extends StatelessWidget {
  const buildPhotoDetail({
    super.key,
    required bool isLoading,
    required this.widget,
  }) : _isLoading = isLoading;

  final bool _isLoading;
  final PhotoDetail widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .6,
                width: MediaQuery.of(context).size.width * .85,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.photo.url!,
                ),
              ),
              SizedBox(height: 10),
              Text(widget.photo.title!),
            ],
          ),
        ],
      ),
    );
  }
}
