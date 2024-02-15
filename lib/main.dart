import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:photo_displayer/global/models/photo.dart';
import 'package:photo_displayer/global/services/api/photo_services.dart';
import 'package:photo_displayer/modules/photos/list_photos/widgets/list_photo.dart';
import 'package:photo_displayer/modules/photos/photo_detail.dart/widgets/photo_detail.dart';
import 'package:provider/provider.dart';

import 'global/connectivity_handler/controller/connectivity_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PhotoServiceProvider(),
      child: const MyApp(),
    ),
  );
}
// void main() {
//   //provider will not handle autommatically update dependents
//   //if you not see this not an error you can add this line 
//   Provider.debugCheckInvalidValueType = null;
//   runApp(
//     Provider<PhotoServiceProvider>(
//       create: (_) => PhotoServiceProvider(),
//       child: const MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhotosList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
