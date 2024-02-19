import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:photo_displayer/global/connectivity_handler/controller/connectivity_controller.dart';
import 'package:photo_displayer/modules/list_photos/widgets/photo_Item_Card.dart';
import 'package:photo_displayer/global/models/photo.dart';
import 'package:photo_displayer/global/services/api/photo_services.dart';
import 'package:provider/provider.dart';

class PhotosList extends StatefulWidget {
  const PhotosList({super.key});

  @override
  State<PhotosList> createState() => _PhotosListState();
}

class _PhotosListState extends State<PhotosList> {
  // Create an instance of connectivitySubscription
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // Create an instance of ConnectivityService
  late ConnectivityService _connectivityService;
  @override
  void initState() {
    // Instantiate the ConnectivityService class and pass the context to it
    _connectivityService = ConnectivityService(context: context);

    // Check for initial connectivity status
    _connectivityService.checkConnectivity();

    // Start checking for connectivity every 5 seconds
    Timer.periodic(const Duration(milliseconds: 2400) * 2, (_) {
      _connectivityService.checkConnectivity();
    });

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen(_connectivityService.updateConnectivity);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

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
              return PhotoItemCard(photos: photos);
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      iconSize: 60,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PhotosList()));
                      },
                      icon: const Icon(Icons.replay_circle_filled_outlined)),
                  Text("No available data , Try to reload")
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
