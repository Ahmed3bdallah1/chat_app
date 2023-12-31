// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCpMrVf4CkYrPwAfTk_bCWCMJ0I-qREclA',
    appId: '1:91331493193:web:3ce37066a6af4e78b1ae98',
    messagingSenderId: '91331493193',
    projectId: 'chatapp-cf842',
    authDomain: 'chatapp-cf842.firebaseapp.com',
    storageBucket: 'chatapp-cf842.appspot.com',
    measurementId: 'G-SLDP6PJYBJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9J7GrEdEfDqKr5Kf-1KPgv6kYK5pKynU',
    appId: '1:91331493193:android:5872375ae2418b07b1ae98',
    messagingSenderId: '91331493193',
    projectId: 'chatapp-cf842',
    storageBucket: 'chatapp-cf842.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLxVLk-AIQGbO-jV3ZzJK4mWuokGr--jI',
    appId: '1:91331493193:ios:ad4800fc05c9f8f5b1ae98',
    messagingSenderId: '91331493193',
    projectId: 'chatapp-cf842',
    storageBucket: 'chatapp-cf842.appspot.com',
    iosBundleId: 'com.example.whatsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBLxVLk-AIQGbO-jV3ZzJK4mWuokGr--jI',
    appId: '1:91331493193:ios:662769d6bac996d7b1ae98',
    messagingSenderId: '91331493193',
    projectId: 'chatapp-cf842',
    storageBucket: 'chatapp-cf842.appspot.com',
    iosBundleId: 'com.example.whatsApp.RunnerTests',
  );
}
