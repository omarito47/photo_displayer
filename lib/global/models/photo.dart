import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart'; // Generated file name

@JsonSerializable() // Add this annotation
class Photo {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json); // Add this factory constructor

  Map<String, dynamic> toJson() => _$PhotoToJson(this); // Add this method
}
