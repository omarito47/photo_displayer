import 'package:flutter/material.dart';
import 'package:photo_displayer/modules/photo_detail.dart/widgets/next_page.dart';
import 'package:photo_displayer/modules/photo_detail.dart/widgets/photo_detail.dart';
import 'package:transparent_image/transparent_image.dart';

class BuildPhotoDetail extends StatelessWidget {
  const BuildPhotoDetail({
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                       return const NextPage();
                      },
                    ),
                  );
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .6,
                  width: MediaQuery.of(context).size.width * .85,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.photo.url!,
                    
                  ),
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
