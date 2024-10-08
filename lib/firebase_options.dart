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
    apiKey: 'AIzaSyDbzi_Kc-IwDX9m2riUQH2EoAaLxU26fp0',
    appId: '1:945198053816:web:0e7d4dc7e9c29ca328f74d',
    messagingSenderId: '945198053816',
    projectId: 'emart-eb39d',
    authDomain: 'emart-eb39d.firebaseapp.com',
    storageBucket: 'emart-eb39d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHpQcoP7T7AYhUbsWIlYsy2b9qqD77srs',
    appId: '1:945198053816:android:07e2b25c7caccc6b28f74d',
    messagingSenderId: '945198053816',
    projectId: 'emart-eb39d',
    storageBucket: 'emart-eb39d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVE4GYIxzsi9ANwncu8sOjmqDXAgjyQdE',
    appId: '1:945198053816:ios:aa946c77b906a7c428f74d',
    messagingSenderId: '945198053816',
    projectId: 'emart-eb39d',
    storageBucket: 'emart-eb39d.appspot.com',
    iosBundleId: 'com.example.eMart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBVE4GYIxzsi9ANwncu8sOjmqDXAgjyQdE',
    appId: '1:945198053816:ios:aa946c77b906a7c428f74d',
    messagingSenderId: '945198053816',
    projectId: 'emart-eb39d',
    storageBucket: 'emart-eb39d.appspot.com',
    iosBundleId: 'com.example.eMart',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDbzi_Kc-IwDX9m2riUQH2EoAaLxU26fp0',
    appId: '1:945198053816:web:b86d68e911aa298228f74d',
    messagingSenderId: '945198053816',
    projectId: 'emart-eb39d',
    authDomain: 'emart-eb39d.firebaseapp.com',
    storageBucket: 'emart-eb39d.appspot.com',
  );

}