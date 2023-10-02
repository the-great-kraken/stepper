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
    apiKey: 'AIzaSyBSyJawpE0K3xG7Q7btzFKjkZOBwh_iujo',
    appId: '1:192447244106:web:73bf9bb56ddc1415da03b3',
    messagingSenderId: '192447244106',
    projectId: 'stepper-3a9fe',
    authDomain: 'stepper-3a9fe.firebaseapp.com',
    storageBucket: 'stepper-3a9fe.appspot.com',
    measurementId: 'G-Z1P2NPQ8GT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIMDqcl4zKf6OUDFDc8ZWXtrPlFoNtnU0',
    appId: '1:192447244106:android:11eead1cda547c6bda03b3',
    messagingSenderId: '192447244106',
    projectId: 'stepper-3a9fe',
    storageBucket: 'stepper-3a9fe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdM7ps_GIR751loruaDPYFww_AbuRP8Mc',
    appId: '1:192447244106:ios:49f8a3f706eefa56da03b3',
    messagingSenderId: '192447244106',
    projectId: 'stepper-3a9fe',
    storageBucket: 'stepper-3a9fe.appspot.com',
    iosClientId: '192447244106-6jeou8geqp1hrrthigac64mhuau9nojl.apps.googleusercontent.com',
    iosBundleId: 'com.example.stepper',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdM7ps_GIR751loruaDPYFww_AbuRP8Mc',
    appId: '1:192447244106:ios:29d844502cd1153fda03b3',
    messagingSenderId: '192447244106',
    projectId: 'stepper-3a9fe',
    storageBucket: 'stepper-3a9fe.appspot.com',
    iosClientId: '192447244106-bp9cftj5gu666q2hatdm0ce1mctm94h0.apps.googleusercontent.com',
    iosBundleId: 'com.example.stepper.RunnerTests',
  );
}