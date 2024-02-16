import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_displayer/global/connectivity_handler/widgets/alert_dialog.dart';


void main() {
  testWidgets('AlertDialogWidget displays correct data', (WidgetTester tester) async {
    // Define the data for the AlertDialogWidget
    final String header = 'Alert Header';
    final String description = 'Alert Description';
    final String imagePath = 'assets/images/alert_icon.svg';
    final String btnText = 'OK';
    final String semanticsLabel = 'Alert Icon';

    bool isConnected = false;
    bool showDialog = false;

    // Build the AlertDialogWidget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  showDialog = true;
                  showDialogWidget(context);
                },
                child: const Text('Show Dialog'),
              );
            },
          ),
        ),
      ),
    );

    // Tap on the button to show the dialog
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    // Verify that the AlertDialogWidget is displayed
    expect(find.byType(AlertDialog), findsOneWidget);

    // Verify the AlertDialogWidget content
    expect(find.text(header), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.text(btnText), findsOneWidget);

    // Verify the AlertDialogWidget icon
    expect(find.byType(SvgPicture), findsOneWidget);
    final svgPicture = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect(svgPicture.semanticsLabel, equals(semanticsLabel));

    // Tap on the button inside the AlertDialogWidget
    await tester.tap(find.text(btnText));
    await tester.pumpAndSettle();

    // Verify that checkConnectivity function is called
    expect(isConnected, equals(true));
    expect(showDialog, equals(false));
  });
}

void showDialogWidget(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var isConnected =false;
      var header="header_mock";
      var description="description_mock";
      var btnText="button_mock";
      var imagePath="image_mock";
      var semanticsLabel="label_mock";
      return AlertDialogWidget().alertDialogWidget(
        checkConnectivity: () {
          // Simulating connectivity check
           isConnected = true;
          var showDialog = false;
        },
        isConnected: isConnected,
        showDialog: showDialog,
        context: context,
        header: header,
        description: description,
        imagePath: imagePath,
        btnText: btnText,
        semanticsLabel: semanticsLabel,
      );
    },
  );
}