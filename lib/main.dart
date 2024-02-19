import 'package:flutter/material.dart';
import 'package:photo_displayer/global/services/api/photo_services.dart';
import 'package:photo_displayer/modules/list_photos/widgets/list_photo.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  final client = http.Client();
  runApp(
    ChangeNotifierProvider(
      create: (_) => PhotoServiceProvider(client),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PhotosList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
