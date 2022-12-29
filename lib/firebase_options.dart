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
    apiKey: 'AIzaSyBlnAeaTtSFOsXO3i3VaQ-8lb2wu-Tr0LU',
    appId: '1:199936839516:web:e57427575ad63e9827fb99',
    messagingSenderId: '199936839516',
    projectId: 'chat-app-rony',
    authDomain: 'chat-app-rony.firebaseapp.com',
    databaseURL: 'https://chat-app-rony-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'chat-app-rony.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1QpLXw_pRTa-PellpjSR9BRyTp6o3Z1A',
    appId: '1:199936839516:android:12b49b634dfee0ec27fb99',
    messagingSenderId: '199936839516',
    projectId: 'chat-app-rony',
    databaseURL: 'https://chat-app-rony-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'chat-app-rony.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCn4MtMWijtb-_nj6B8L5t6olh66RQnOZ0',
    appId: '1:199936839516:ios:ee328c66bfa9bf7827fb99',
    messagingSenderId: '199936839516',
    projectId: 'chat-app-rony',
    databaseURL: 'https://chat-app-rony-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'chat-app-rony.appspot.com',
    androidClientId: '199936839516-b5kr76sensej7g77cm7d265kjaff577j.apps.googleusercontent.com',
    iosClientId: '199936839516-o78ahgmfdmnnsmb3t8fnkh9nntf9mjci.apps.googleusercontent.com',
    iosBundleId: 'com.ta.sikasir',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCn4MtMWijtb-_nj6B8L5t6olh66RQnOZ0',
    appId: '1:199936839516:ios:ee328c66bfa9bf7827fb99',
    messagingSenderId: '199936839516',
    projectId: 'chat-app-rony',
    databaseURL: 'https://chat-app-rony-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'chat-app-rony.appspot.com',
    androidClientId: '199936839516-b5kr76sensej7g77cm7d265kjaff577j.apps.googleusercontent.com',
    iosClientId: '199936839516-o78ahgmfdmnnsmb3t8fnkh9nntf9mjci.apps.googleusercontent.com',
    iosBundleId: 'com.ta.sikasir',
  );
}
