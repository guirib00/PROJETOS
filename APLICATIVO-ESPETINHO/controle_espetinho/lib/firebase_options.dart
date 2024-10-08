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
    apiKey: 'AIzaSyBw-7Sfwx7IOjRVEn7lyK2gEqCpGUR8nKw',
    appId: '1:808772992303:web:7680314b9640109b9e35da',
    messagingSenderId: '808772992303',
    projectId: 'controleespetinho',
    authDomain: 'controleespetinho.firebaseapp.com',
    databaseURL: 'https://controleespetinho-default-rtdb.firebaseio.com',
    storageBucket: 'controleespetinho.appspot.com',
    measurementId: 'G-SLLD3WS67M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkVZcg5xWN0yG5yZHqyHxWUxWgYdQRK60',
    appId: '1:808772992303:android:1c28c242723745c89e35da',
    messagingSenderId: '808772992303',
    projectId: 'controleespetinho',
    databaseURL: 'https://controleespetinho-default-rtdb.firebaseio.com',
    storageBucket: 'controleespetinho.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEl3EXQLPISFh1uEQWEGVoJgG5DRDrGIU',
    appId: '1:808772992303:ios:4744ecf3bf7d650a9e35da',
    messagingSenderId: '808772992303',
    projectId: 'controleespetinho',
    databaseURL: 'https://controleespetinho-default-rtdb.firebaseio.com',
    storageBucket: 'controleespetinho.appspot.com',
    iosBundleId: 'com.example.controleEspetinho',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAEl3EXQLPISFh1uEQWEGVoJgG5DRDrGIU',
    appId: '1:808772992303:ios:4744ecf3bf7d650a9e35da',
    messagingSenderId: '808772992303',
    projectId: 'controleespetinho',
    databaseURL: 'https://controleespetinho-default-rtdb.firebaseio.com',
    storageBucket: 'controleespetinho.appspot.com',
    iosBundleId: 'com.example.controleEspetinho',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBw-7Sfwx7IOjRVEn7lyK2gEqCpGUR8nKw',
    appId: '1:808772992303:web:1f0b584a8f5f43c49e35da',
    messagingSenderId: '808772992303',
    projectId: 'controleespetinho',
    authDomain: 'controleespetinho.firebaseapp.com',
    databaseURL: 'https://controleespetinho-default-rtdb.firebaseio.com',
    storageBucket: 'controleespetinho.appspot.com',
    measurementId: 'G-0R085DKEER',
  );

}