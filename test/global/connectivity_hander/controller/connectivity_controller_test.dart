// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:photo_displayer/global/connectivity_handler/controller/connectivity_controller.dart';
// import 'package:photo_displayer/global/connectivity_handler/widgets/alert_dialog.dart';

// class MockConnectivity extends Mock implements Connectivity {}

// class MockConnectivityResult extends Mock implements ConnectivityResult {}

// class MockBuildContext extends Mock implements BuildContext {}

// class MockAlertDialogWidget extends Mock implements AlertDialogWidget {}

// void main() {
//   late ConnectivityService connectivityService;
//   late MockConnectivity mockConnectivity;
//   late MockBuildContext mockBuildContext;
//   late MockAlertDialogWidget mockAlertDialogWidget;

//   setUp(() {
//     mockConnectivity = MockConnectivity();
//     mockBuildContext = MockBuildContext();
//     mockAlertDialogWidget = MockAlertDialogWidget();

//     connectivityService = ConnectivityService(context: mockBuildContext);
//     connectivityService._alertDialogWidget = mockAlertDialogWidget;
//   });

//   test('checkConnectivity should update connectivity status and handle dialog visibility', () async {
//     final mockConnectivityResult = MockConnectivityResult();
//     when(mockConnectivity.checkConnectivity()).thenAnswer((_) => Future.value(mockConnectivityResult));
//     when(mockConnectivityResult != ConnectivityResult.none).thenReturn(true);

//     connectivityService.checkConnectivity();

//     expect(connectivityService()._isConnected, equals(true));
//     verify(mockConnectivity.checkConnectivity()).called(1);
//     verify(mockAlertDialogWidget.handleDialogVisibility()).called(1);
//   });

//   test('updateConnectivity should update connectivity status and handle dialog visibility', () {
//     final mockConnectivityResult = MockConnectivityResult();
//     when(mockConnectivityResult != ConnectivityResult.none).thenReturn(true);

//     connectivityService.updateConnectivity(mockConnectivityResult);

//     expect(connectivityService._isConnected, equals(true));
//     verify(mockAlertDialogWidget.handleDialogVisibility()).called(1);
//   });

//   test('handleDialogVisibility should show alert dialog when connection goes down and hide it when connection is restored', () {
//     final mockAlertDialog = MockAlertDialog();
//     when(mockAlertDialogWidget.alertDialogWidget(
//       checkConnectivity: anyNamed('checkConnectivity'),
//       isConnected: connectivityService._isConnected,
//       showDialog: connectivityService._showDialog,
//       context: mockBuildContext,
//       header: anyNamed('header'),
//       description: anyNamed('description'),
//       btnText: anyNamed('btnText'),
//       imagePath: anyNamed('imagePath'),
//       semanticsLabel: anyNamed('semanticsLabel'),
//     )).thenReturn(mockAlertDialog);

//     // Simulate connection going down
//     connectivityService._isConnected = false;
//     connectivityService.handleDialogVisibility();

//     expect(connectivityService._showDialog, equals(true));
//     verify(mockAlertDialogWidget.alertDialogWidget(
//       checkConnectivity: connectivityService.checkConnectivity,
//       isConnected: connectivityService._isConnected,
//       showDialog: connectivityService._showDialog,
//       context: mockBuildContext,
//       header: 'Whoops!',
//       description: 'Pas de connexion Internet.\nS\'il vous plait, vérifiez votre connexion internet.',
//       btnText: 'Réessayer',
//       imagePath: 'assets/svg/wifi-x.svg',
//       semanticsLabel: 'No Connection Icon',
//     )).called(1);
//     verify(mockBuildContext).findAncestorStateOfType(TypeMatcher<NavigatorState>());

//     // Simulate connection being restored
//     connectivityService._isConnected = true;
//     connectivityService.handleDialogVisibility();

//     expect(connectivityService._showDialog, equals(false));
//     verify(mockBuildContext.findAncestorStateOfType(TypeMatcher<NavigatorState>())).called(1);
//     verify(mockNavigatorState.pop()).called(1);
//   });

//   test('showAlert should show the alert dialog', () {
//     final mockAlertDialog = MockAlertDialog();
//     when(mockAlertDialogWidget.alertDialogWidget(
//       checkConnectivity: connectivityService.checkConnectivity,
//       isConnected: connectivityService._isConnected,
//       showDialog: connectivityService._showDialog,
//       context: mockBuildContext,
//       header: 'Whoops!',
//       description: 'Pas de connexion Internet.\nS\'il vous plait, vérifiez votre connexion internet.',
//       btnText: 'Réessayer',
//       imagePath: 'assets/svg/wifi-x.svg',
//       semanticsLabel: 'No Connection Icon',
//     )).thenReturn(mockAlertDialog);

//     final mockShowDialog = MockShowDialog();
//     when(mockBuildContext.findAncestorStateOfType(TypeMatcher<NavigatorState>())).thenReturn(mockNavigatorState);
//     when(mockNavigatorState.pop()).thenAnswer((_) {
//       connectivityService._showDialog = false;
//     });
//     when(mockShowDialog(
//       context: mockBuildContext,
//       barrierDismissible: false,
//       builder: anyNamed('builder'),
//     )).thenAnswer((_) => Future.value(mockAlertDialog));

//     connectivityService.showAlert(mockBuildContext);

//     expect(connectivityService._showDialog, equals(true));
//     } ); }