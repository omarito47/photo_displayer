import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_displayer/global/models/photo.dart';
import 'package:photo_displayer/global/services/api/photo_services.dart';
import 'package:photo_displayer/modules/list_photos/widgets/list_photo.dart';
import 'package:photo_displayer/modules/photo_detail.dart/widgets/photo_detail.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

// Mock PhotoServiceProvider
class MockPhotoServiceProvider extends Mock implements PhotoServiceProvider {}

void main() {
  group('PhotosList', () {
    late MockPhotoServiceProvider mockPhotoServiceProvider;

    setUp(() {
      mockPhotoServiceProvider = MockPhotoServiceProvider();
    });

    testWidgets('renders CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      // Mock the behavior of getPhotos to return null
      when(mockPhotoServiceProvider.getPhotos()).thenAnswer((_) async => []);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => mockPhotoServiceProvider,
            child: PhotosList(),
          ),
        ),
      );

      // Expect CircularProgressIndicator to be rendered
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('No data available'), findsNothing);
    });

    testWidgets('renders list of photos when data is available',
        (WidgetTester tester) async {
      // Mock the behavior of getPhotos to return a list of photos
      final mockPhotos = [
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
      when(mockPhotoServiceProvider.getPhotos())
          .thenAnswer((_) async => mockPhotos);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => mockPhotoServiceProvider,
            child: PhotosList(),
          ),
        ),
      );

      // Expect CircularProgressIndicator to disappear
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('No data available'), findsNothing);

      // Expect the list of photos to be rendered
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(2));
      // Verify that the correct number of photo items is displayed
      expect(find.byType(GestureDetector), findsNWidgets(mockPhotos.length));

      // Verify that each photo item displays the correct data
      for (int i = 0; i < mockPhotos.length; i++) {
        final photo = mockPhotos[i];

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
        final photoDetail =
            tester.widget<PhotoDetail>(find.byType(PhotoDetail));
        expect(photoDetail.photo, equals(photo));
      }
    });

    testWidgets('navigates to PhotoDetail when a photo is tapped',
        (WidgetTester tester) async {
      // Mock the behavior of getPhotos to return a list of photos
      final mockPhotos = [
        Photo(
          albumId: 1,
          id: 1,
          title: 'Mock Photo 1',
          url: 'https://example.com/photo1.jpg',
          thumbnailUrl: 'https://example.com/thumbnail1.jpg',
        ),
      ];
      when(mockPhotoServiceProvider.getPhotos())
          .thenAnswer((_) async => mockPhotos);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => mockPhotoServiceProvider,
            child: PhotosList(),
          ),
        ),
      );

      // Tap on the photo
      await tester.tap(find.byType(GestureDetector));

      // Wait for the navigation transition to complete
      await tester.pumpAndSettle();

      // Expect PhotoDetail widget to be rendered
      expect(find.byType(PhotoDetail), findsOneWidget);
    });
  });
}
