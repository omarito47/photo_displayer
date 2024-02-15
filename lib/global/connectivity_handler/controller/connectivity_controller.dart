import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:photo_displayer/global/connectivity_handler/widgets/alert_dialog.dart';


/// Configuration class for network connectivity
class ConnectivityService {
  static bool _isConnected = true;
  static bool _showDialog = false;
  BuildContext context;

  ConnectivityService({required this.context});
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();

  void checkConnectivity() {
    Connectivity().checkConnectivity().then((ConnectivityResult result) {
      _isConnected = result != ConnectivityResult.none;

      handleDialogVisibility();
    });
  }

  void updateConnectivity(ConnectivityResult result) {
    _isConnected = result != ConnectivityResult.none;

    handleDialogVisibility();
  }

  void handleDialogVisibility() {
    // Show alert dialog when connection goes down
    if (!_isConnected && !_showDialog) {
      _showDialog = true;
      showAlert(context);
    } else if (_isConnected && _showDialog) {
      _showDialog = false;

      // Dismiss the dialog when connection is restored
      Navigator.of(context).pop();
    }
  }

  void showAlert(BuildContext context) {
    var alert = _alertDialogWidget.alertDialogWidget(
        checkConnectivity: checkConnectivity,
        isConnected: _isConnected,
        showDialog: _showDialog,
        context: context,
        header: 'Whoops!',
        description:
            'Pas de connexion Internet.\nS\'il vous plait, vérifiez votre connexion internet.',
        btnText: 'Réessayer',
        imagePath: 'assets/svg/wifi-x.svg',
        semanticsLabel: 'No Connection Icon');

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
