import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_displayer/global/models/photo.dart';
import 'package:photo_displayer/global/services/api/photo_services.dart';
import 'package:photo_displayer/modules/list_photos/widgets/photo_Item_Card.dart';
import 'package:photo_displayer/modules/photo_detail.dart/widgets/photo_detail.dart';
import 'package:transparent_image/transparent_image.dart';
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

  testWidgets('photoItemCard displays correct data and navigates to PhotoDetail',
      (WidgetTester tester) async {
    // Create a list of sample photos
    final List<Photo> photos = [
      Photo(
          albumId: 1,
          id: 1,
          title: 'Mock Photo 1',
          url: 'https://example.com/photo1.jpg',
          thumbnailUrl: 'https://example.com/thumbnail1.jpg',
        ),
        Photo(
          albumId: 1,
          id: 2,
          title: 'Mock Photo 2',
          url: 'https://example.com/photo2.jpg',
          thumbnailUrl: 'https://example.com/thumbnail2.jpg',
        ),
    ];

    // Build the photoItemCard widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: photoItemCard(photos: photos),
        ),
      ),
    );

    // Verify that the correct number of photo items is displayed
    expect(find.byType(GestureDetector), findsNWidgets(photos.length));

    // Verify that each photo item displays the correct data
    for (int i = 0; i < photos.length; i++) {
      final photo = photos[i];

      // Find the photo item container
      final containerFinder = find.descendant(
        of: find.byType(GestureDetector).at(i),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsOneWidget);

     
      // Verify the thumbnail image
      final imageFinder = find.descendant(
        of: containerFinder,
        matching: find.byType(FadeInImage),
      );
      expect(imageFinder, findsOneWidget);

      final fadeInImage = tester.widget<FadeInImage>(imageFinder);
      expect(fadeInImage.placeholder, equals(kTransparentImage));
      expect(fadeInImage.image, equals(photo.thumbnailUrl));

      // Verify the title text
      final textFinder = find.descendant(
        of: containerFinder,
        matching: find.byType(Text),
      );
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.data, equals(photo.title));

      // Tap on the photo item
      await tester.tap(find.byType(GestureDetector).at(i));
      await tester.pumpAndSettle();

      // Verify that it navigates to PhotoDetail with the correct photo
      expect(find.byType(PhotoDetail), findsOneWidget);
      final photoDetail = tester.widget<PhotoDetail>(find.byType(PhotoDetail));
      expect(photoDetail.photo, equals(photo));
    }
  });
}