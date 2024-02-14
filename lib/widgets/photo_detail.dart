import 'package:flutter/material.dart';
import 'package:photo_displayer/models/photo.dart';

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
    await Future.delayed(Duration(seconds: 2)); // Simulating photo loading delay
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
              CircularProgressIndicator()
            else
              Column(
                children: [
                  Image.network(widget.photo.url!),
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