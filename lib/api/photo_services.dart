import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:photo_displayer/models/photo.dart';

class PhotoServices {
  static Future<List<Photo>> getphotos() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Photo.fromJson(e)).toList();
  }
}
