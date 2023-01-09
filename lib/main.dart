// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "sikasir",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator())));
        }

        //Get data
        return GetMaterialApp(
          title: "Sikasir",
          initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
          getPages: AppPages.routes,
        );
      },
    );

    // return FutureBuilder(
    //   future: _initialization,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       return ErrorScreen();
    //     }

    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return FutureBuilder(
    //         future: Future.delayed(const Duration(seconds: 3)),
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.done) {
    //             return Obx(() => GetMaterialApp(
    //                   debugShowCheckedModeBanner: false,
    //                   title: "SiKasir",
    //                   initialRoute: authC.isSkipIntro.isTrue
    //                       ? authC.isAuth.isTrue
    //                           ? Routes.HOME
    //                           : Routes.LOGIN
    //                       : Routes.INTRODUCTION,
    //                   getPages: AppPages.routes,
    //                 ));
    //           }

    //           return FutureBuilder(
    //             future: authC.firstInitialized(),
    //             builder: (context, snapshot) => const SplashScreen(),
    //           );
    //         },
    //       );
    //     }
    //     return LoadingScreen();
    //   },
    // );
  }
}
