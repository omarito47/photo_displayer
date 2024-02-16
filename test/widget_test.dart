import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_displayer/global/models/photo.dart';
import 'package:photo_displayer/global/services/api/photo_services.dart';
import 'package:photo_displayer/main.dart';
import 'package:photo_displayer/modules/list_photos/widgets/list_photo.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'global/services/api/photo_services_test.mocks.dart';

void main() {
  final mockClient = MockClient();
  testWidgets('PhotosList Widget Test', (WidgetTester tester) async {
    
    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => PhotoServiceProvider(mockClient),
          child:  PhotosList(),
        ),
      ),
    );

    // Verify that the widget tree contains the expected widgets
    expect(find.byType(MyApp), findsOneWidget);
    

    // Perform any interactions or additional assertions as needed
    // For example, you can simulate scrolling and check if the photos are loaded correctly

    // Example: Scroll down and wait for the widget to rebuild
    // await tester.drag(find.byType(ListView), const Offset(0.0, -500.0));
    // await tester.pumpAndSettle();

    // // Verify that the photos are loaded
    // expect(find.byType(Photo), findsNWidgets(10)); // Assuming 10 photos are loaded

    // // Additional test cases can be added to cover different scenarios and behaviors
  });
}