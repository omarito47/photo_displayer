import 'package:flutter/material.dart';
import 'package:photo_displayer/global/models/photo.dart';
import 'package:shimmer/shimmer.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Detail"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .5,
                  color: Colors.white,
                ),
              )
            else
              Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      child: Image.network(widget.photo.url!)),
                  SizedBox(height: 10),
                  Text(widget.photo.title!),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
