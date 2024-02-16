

import 'package:flutter_test/flutter_test.dart';
import 'package:photo_displayer/global/models/photo.dart';

void main() {
  group('Photo', () {
    test('fromJson() should correctly deserialize a JSON map', () {
      // Arrange
      Map<String, dynamic> json = {
        'albumId': 1,
        'id': 1,
        'title': 'Sample Title',
        'url': 'https://example.com/photo.jpg',
        'thumbnailUrl': 'https://example.com/thumbnail.jpg',
      };

      // Act
      Photo photo = Photo.fromJson(json);

      // Assert
      expect(photo.albumId, equals(1));
      expect(photo.id, equals(1));
      expect(photo.title, equals('Sample Title'));
      expect(photo.url, equals('https://example.com/photo.jpg'));
      expect(photo.thumbnailUrl, equals('https://example.com/thumbnail.jpg'));
    });

    test('toJson() should correctly serialize the Photo object to a JSON map', () {
      // Arrange
      Photo photo = Photo(
        albumId: 1,
        id: 1,
        title: 'Sample Title',
        url: 'https://example.com/photo.jpg',
        thumbnailUrl: 'https://example.com/thumbnail.jpg',
      );

      // Act
      Map<String, dynamic> json = photo.toJson();

      // Assert
      expect(json['albumId'], equals(1));
      expect(json['id'], equals(1));
      expect(json['title'], equals('Sample Title'));
      expect(json['url'], equals('https://example.com/photo.jpg'));
      expect(json['thumbnailUrl'], equals('https://example.com/thumbnail.jpg'));
    });
  });
}