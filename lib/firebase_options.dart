// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCb4d01gSaDwPQQahGPMjt6PosBv8zeNtU',
    appId: '1:593512082924:web:3c23cd4c5edc6604fba4c9',
    messagingSenderId: '593512082924',
    projectId: 'inventory-f570e',
    authDomain: 'inventory-f570e.firebaseapp.com',
    storageBucket: 'inventory-f570e.firebasestorage.app',
    measurementId: 'G-9R7SL72LVC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5nELDKARR9zeh3pKiSGF4PQdRT51EIjY',
    appId: '1:593512082924:android:427200f1806acd0afba4c9',
    messagingSenderId: '593512082924',
    projectId: 'inventory-f570e',
    storageBucket: 'inventory-f570e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBBppUu1iXd9AymiW7azeXFdWwNtjbrL4',
    appId: '1:593512082924:ios:1feaaa9754dc4a84fba4c9',
    messagingSenderId: '593512082924',
    projectId: 'inventory-f570e',
    storageBucket: 'inventory-f570e.firebasestorage.app',
    androidClientId: '593512082924-42ucjqvm044da58goamulmlcoh1r63dp.apps.googleusercontent.com',
    iosClientId: '593512082924-n0su9q6uuk9pg4qva2tkfh4bnrhb31tb.apps.googleusercontent.com',
    iosBundleId: 'com.example.inventoryManagementSystem',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDBBppUu1iXd9AymiW7azeXFdWwNtjbrL4',
    appId: '1:593512082924:ios:1feaaa9754dc4a84fba4c9',
    messagingSenderId: '593512082924',
    projectId: 'inventory-f570e',
    storageBucket: 'inventory-f570e.firebasestorage.app',
    androidClientId: '593512082924-42ucjqvm044da58goamulmlcoh1r63dp.apps.googleusercontent.com',
    iosClientId: '593512082924-n0su9q6uuk9pg4qva2tkfh4bnrhb31tb.apps.googleusercontent.com',
    iosBundleId: 'com.example.inventoryManagementSystem',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCb4d01gSaDwPQQahGPMjt6PosBv8zeNtU',
    appId: '1:593512082924:web:5efb1d840b000a60fba4c9',
    messagingSenderId: '593512082924',
    projectId: 'inventory-f570e',
    authDomain: 'inventory-f570e.firebaseapp.com',
    storageBucket: 'inventory-f570e.firebasestorage.app',
    measurementId: 'G-59XSW135Q8',
  );

}