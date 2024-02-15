import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_displayer/global/models/photo.dart';
import 'package:provider/provider.dart';

class PhotoServiceProvider with ChangeNotifier {
  Future<List<Photo>> getPhotos() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Photo.fromJson(e)).toList();
  }
}