import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_displayer/global/models/photo.dart';
import 'package:photo_displayer/global/services/api/photo_services.dart';
import 'package:photo_displayer/modules/photo_detail.dart/widgets/photo_detail.dart';
import 'package:shimmer/shimmer.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockPhotoServiceProvider extends Mock implements PhotoServiceProvider {
  @override
  Future<List<Photo>> getPhotos() async {
    // Create a list of mock photos
    List<Photo> mockPhotos = [
      Photo(
        albumId: 1,
        id: 1,
        title: "Mock Photo 1",
        url: "https://example.com/photo1.jpg",
        thumbnailUrl: "https://example.com/thumbnail1.jpg",
      ),
      Photo(
        albumId: 1,
        id: 2,
        title: "Mock Photo 2",
        url: "https://example.com/photo2.jpg",
        thumbnailUrl: "https://example.com/thumbnail2.jpg",
      ),
    ];

    return Future.value(mockPhotos);
  }
}

void main() {
  late MockHttpClient mockHttpClient;
  late MockPhotoServiceProvider mockPhotoServiceProvider;
  late List<Photo> listPhoto = [];

  setUp(() async {
    mockHttpClient = MockHttpClient();
    mockPhotoServiceProvider = MockPhotoServiceProvider();
    listPhoto = await mockPhotoServiceProvider.getPhotos();
  });

  testWidgets('PhotoDetail widget test', (WidgetTester tester) async {
    // Create a mock photo for testing

    // Build the PhotoDetail widget with the mock photo
    await tester.pumpWidget(
      MaterialApp(
        home: PhotoDetail(photo: listPhoto[0]),
      ),
    );

    // Verify that the loading state is initially shown
    expect(find.byType(Shimmer), findsOneWidget);
    expect(find.byType(Image), findsNothing);
    expect(find.text('Photo Detail'), findsNothing);

    // Wait for the photo to finish loading
    await tester.pump(Duration(seconds: 3));

    // Verify that the loaded state is shown
    expect(find.byType(Shimmer), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Photo Detail'), findsOneWidget);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(Center), findsWidgets);


  });
}
