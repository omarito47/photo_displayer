import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:photo_displayer/global/models/photo.dart';
import 'package:photo_displayer/global/services/api/photo_services.dart';

import 'photo_services_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("Fetch photo", () async {
    
    test('return a list of photo if the http call complete succefully',
        () async {
      final mockClient = MockClient();
      when(mockClient.get(Uri.parse(
              "https://jsonplaceholder.typicode.com/albums/1/photos")))
          .thenAnswer((_) async => http.Response(
              '[{"albumId":1,"id":1,"title":"mock_title","url":"https://example.com/photo.jpg","thumbnailUrl":"https://example.com/photo.jpg"},{"albumId":1,"id":1,"title":"mock_title","url":"https://example.com/photo.jpg","thumbnailUrl":"https://example.com/photo.jpg"}]',
              200));

      expect(await PhotoServiceProvider(mockClient).getPhotos(),
          isA<List<Photo>>());
    });
    test('throws an exception if the http call completes with an error',
        () async {
      final mockClient = MockClient();
      when(mockClient.get(Uri.parse(
              "https://jsonplaceholder.typicode.com/albums/1/photos")))
          .thenAnswer((_) async => http.Response(
              'Not Found',
              404));

      expect(await PhotoServiceProvider(mockClient).getPhotos(),
          throwsException);
    });
  });
}
