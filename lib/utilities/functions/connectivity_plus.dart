// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';

// class ConnectivityService {
//   static final ConnectivityService _instance = ConnectivityService._internal();
//   final Connectivity _connectivity = Connectivity();

//   factory ConnectivityService() {
//     return _instance;
//   }

//   ConnectivityService._internal();

//   // Correct return type to Stream<ConnectivityResult>
//   Stream<ConnectivityResult> get connectivityStream => _connectivity.onConnectivityChanged;

//   void listenToConnectivity(BuildContext context) {
//     connectivityStream.listen((ConnectivityResult result) {
//       if (result == ConnectivityResult.none) {
//         _showSnackbar(context, 'No internet connection. Please reconnect.');
//       } else {
//         _showSnackbar(context, 'Connected to the internet.');
//       }
//     });
//   }

//   void _showSnackbar(BuildContext context, String message) {
//     final snackBar = SnackBar(content: Text(message));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }