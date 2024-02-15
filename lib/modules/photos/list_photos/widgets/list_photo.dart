import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:photo_displayer/global/connectivity_handler/controller/connectivity_controller.dart';
import 'package:photo_displayer/global/models/photo.dart';
import 'package:photo_displayer/global/services/api/photo_services.dart';
import 'package:provider/provider.dart';

import '../../photo_detail.dart/widgets/photo_detail.dart';

class PhotosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final photoServiceProvider = Provider.of<PhotoServiceProvider>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Photo>>(
          future: photoServiceProvider.getPhotos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final photos = snapshot.data!;
              return buildPhotos(photos);
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildPhotos(List<Photo> photos) {
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
            color: Colors.grey.shade300,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: 100,
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(flex: 1, child: Image.network(photo.thumbnailUrl!)),
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
